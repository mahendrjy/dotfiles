"""
Core features for StudyCompanion add-on.
Implements card rendering with images, quotes, and website embedding.
"""

import html
from urllib.parse import quote as urlquote

from .config_manager import get_config
from .image_manager import pick_random_image_filenames, sanitize_folder_name
from .quotes import get_random_quote, get_unique_random_quotes


_current_card_id: int | None = None
_website_iframe_injected: bool = False


def inject_random_image(text: str, card, kind: str) -> str:
    """
    Hook for card_will_show.
    Injects images, quotes, and website into card display.
    kind: "reviewQuestion", "reviewAnswer", etc.
    """
    global _current_card_id, _website_iframe_injected
    
    cfg = get_config()

    if not cfg.get("enabled", True):
        return text

    if kind.endswith("Question") and not cfg.get("show_on_question", True):
        return text
    if kind.endswith("Answer") and not cfg.get("show_on_answer", True):
        return text

    card_id = card.id if card else None
    is_new_card = (card_id != _current_card_id)
    if is_new_card:
        _current_card_id = card_id

    images_count = int(cfg.get("images_to_show", 1) or 1)
    filenames = pick_random_image_filenames(cfg, images_count)
    if not filenames:
        return text

    folder_name = sanitize_folder_name(cfg.get("folder_name", "study_companion_images"))

    max_w = cfg.get("max_width_percent", 80)
    max_h = cfg.get("max_height_vh", 60)

    website_url = str(cfg.get("website_url", "")).strip()
    website_display_mode = str(cfg.get("website_display_mode", "mobile")).lower()
    show_quotes = cfg.get("show_motivation_quotes", True)
    
    total_items_needing_quotes = images_count
    if website_url and website_display_mode == "mobile":
        total_items_needing_quotes += 1
    
    unique_quotes = get_unique_random_quotes(total_items_needing_quotes) if show_quotes else []
    quote_index = 0

    images_cells = []
    columns = min(3, max(1, images_count))
    cell_width_css = f"calc({100/columns:.4f}% - 12px)"
    
    for idx, fname in enumerate(filenames):
        # Insert website in mobile mode after first image
        if website_url and website_display_mode == "mobile" and idx == 1:
            website_cell = _create_website_cell(cfg, quote_index, unique_quotes if show_quotes else [])
            if website_cell:
                images_cells.append(website_cell)
                quote_index += 1

        img_src_i = f"{folder_name}/{urlquote(fname, safe='/')}"
        title_attr_i = html.escape(fname, quote=True)
        filename_escaped_i = html.escape(fname, quote=True)

        # Image styling
        img_style_parts = [
            "width:100%",
            f"height:{max_h}vh" if isinstance(max_h, (int, float)) and max_h > 0 else "height:auto",
            "object-fit:cover",
            "object-position:center",
            "border-radius:8px",
            "display:block",
        ]
        img_style = "; ".join(img_style_parts)

        # Quote and delete button row
        quote_delete_row = _build_quote_delete_row(
            show_quotes, quote_index, unique_quotes, filename_escaped_i
        )
        quote_index += 1 if show_quotes and quote_index < len(unique_quotes) else 0

        cell_html = (
            f"<div style=\"flex:0 0 {cell_width_css}; max-width:{cell_width_css}; text-align:center;\">"
            f"<img src=\"{img_src_i}\" style=\"{img_style}\" title=\"{title_attr_i}\">"
            f"{quote_delete_row}"
            f"</div>"
        )
        images_cells.append(cell_html)

    # Desktop mode: inject website above images
    website_html = ""
    if website_url and website_display_mode == "desktop":
        website_html = _build_desktop_website(cfg, show_quotes)

    extra_html = f"""
        {website_html}
        <div style="text-align:center; margin-top:15px;" id="random-image-container">
            <div style="display:flex; flex-wrap:wrap; justify-content:center; gap:8px;">
                {''.join(images_cells)}
            </div>
        </div>
    <script>
    (function() {{
        function deleteRandomImage(filename) {{
            if (typeof pycmd !== 'undefined') {{
                pycmd('randomImageDelete:' + filename);
            }} else if (typeof window.pycmd !== 'undefined') {{
                window.pycmd('randomImageDelete:' + filename);
            }}
        }}
        window.deleteRandomImage = deleteRandomImage;
    }})();
    </script>
    """
    return text + extra_html


def _build_quote_delete_row(show_quotes: bool, quote_index: int, quotes: list[str], filename_escaped: str) -> str:
    """Build the quote and delete button row for an image."""
    if show_quotes and quote_index < len(quotes):
        quote_text = html.escape(quotes[quote_index])
        return f"""
            <div style="display:flex; align-items:flex-start; margin-top:8px; gap:4px;">
                <div style="flex:1; font-size:0.9em; color:#fff; font-style:italic; text-align:left; line-height:1.3;">
                    {quote_text}
                </div>
                <button onclick="deleteRandomImage('{filename_escaped}')" 
                        style="background:transparent; border:none; cursor:pointer; padding:0; font-size:0.7em; color:#ff6b6b; flex-shrink:0;" 
                        title="Delete">
                    🗑️
                </button>
            </div>
            """
    else:
        return f"""
            <div style="text-align:center; margin-top:8px;">
                <button onclick="deleteRandomImage('{filename_escaped}')" 
                        style="background:transparent; border:none; cursor:pointer; padding:0; font-size:0.7em; color:#ff6b6b;" 
                        title="Delete">
                    🗑️
                </button>
            </div>
            """


def _create_website_cell(cfg: dict, quote_index: int, quotes: list[str]) -> str:
    """Create a website cell for mobile mode grid layout."""
    global _website_iframe_injected
    
    website_url = str(cfg.get("website_url", "")).strip()
    if not website_url:
        return ""
    
    website_height_vh = int(cfg.get("website_height_vh", 50) or 50)
    website_width_percent = int(cfg.get("website_width_percent", 100) or 100)
    cell_width_css = f"calc(33.33% - 12px)"
    
    quote_text = ""
    if quote_index < len(quotes):
        quote_text = html.escape(quotes[quote_index])
    
    quote_delete_row = f"""
    <div style="display:flex; align-items:flex-start; margin-top:8px; gap:4px;">
        <div style="flex:1; font-size:0.9em; color:#fff; font-style:italic; text-align:left; line-height:1.3;">
            {quote_text}
        </div>
    </div>
    """
    
    if not _website_iframe_injected:
        website_cell = f"""
<div style="flex:0 0 {cell_width_css}; max-width:{cell_width_css}; text-align:center;">
    <div id="persistent-website-container" style="width:{website_width_percent}%; margin:0 auto;">
        <iframe id="persistent-website-iframe" 
                src="{html.escape(website_url, quote=True)}" 
                style="width:100%; height:{website_height_vh}vh; border-radius:4px; display:block;"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen>
        </iframe>
    </div>
    {quote_delete_row}
    <script>
    (function() {{
        var container = document.getElementById('persistent-website-container');
        if (container) {{
            window._persistentWebsiteContainer = container;
        }}
    }})();
    </script>
</div>
"""
        _website_iframe_injected = True
    else:
        website_cell = f"""
<div style="flex:0 0 {cell_width_css}; max-width:{cell_width_css}; text-align:center;">
    <div id="persistent-website-container-placeholder"></div>
    {quote_delete_row}
    <script>
    (function() {{
        var placeholder = document.getElementById('persistent-website-container-placeholder');
        if (placeholder) {{
            if (window._persistentWebsiteContainer) {{
                placeholder.parentNode.replaceChild(window._persistentWebsiteContainer, placeholder);
            }} else {{
                var container = document.createElement('div');
                container.id = 'persistent-website-container';
                container.style.cssText = 'width:{website_width_percent}%; margin:0 auto;';
                
                var iframe = document.createElement('iframe');
                iframe.id = 'persistent-website-iframe';
                iframe.src = '{html.escape(website_url, quote=True).replace("'", "&#39;")}';
                iframe.style.cssText = 'width:100%; height:{website_height_vh}vh; border-radius:4px; display:block;';
                iframe.setAttribute('frameborder', '0');
                iframe.setAttribute('allow', 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture');
                iframe.setAttribute('allowfullscreen', '');
                
                container.appendChild(iframe);
                placeholder.parentNode.replaceChild(container, placeholder);
                window._persistentWebsiteContainer = container;
            }}
        }}
    }})();
    </script>
</div>
"""
    return website_cell


def _build_desktop_website(cfg: dict, show_quotes: bool) -> str:
    """Build desktop website HTML (full-width above images)."""
    global _website_iframe_injected
    
    website_url = str(cfg.get("website_url", "")).strip()
    website_height_vh = int(cfg.get("website_height_vh", 50) or 50)
    
    desktop_website_quote = get_random_quote() if show_quotes else ""
    desktop_quote_html = ""
    if show_quotes and desktop_website_quote:
        desktop_quote_html = f"""
            <div style="margin-top:8px; font-size:0.9em; color:#fff; font-style:italic; text-align:left;">
                {html.escape(desktop_website_quote)}
            </div>
            """
    
    if not _website_iframe_injected:
        website_html = f"""
<div id="persistent-website-container" style="width:100%; margin-top:20px; margin-bottom:20px;">
    <iframe id="persistent-website-iframe" 
            src="{html.escape(website_url, quote=True)}" 
            style="width:100%; height:{website_height_vh}vh; border:1px solid #ccc; border-radius:4px; display:block;"
            frameborder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen>
    </iframe>
</div>
{desktop_quote_html}
<script>
(function() {{
    var container = document.getElementById('persistent-website-container');
    if (container) {{
        window._persistentWebsiteContainer = container;
    }}
}})();
</script>
"""
        _website_iframe_injected = True
    else:
        website_html = f"""
<div id="persistent-website-container-placeholder"></div>
{desktop_quote_html}
<script>
(function() {{
    var placeholder = document.getElementById('persistent-website-container-placeholder');
    if (placeholder) {{
        if (window._persistentWebsiteContainer) {{
            placeholder.parentNode.replaceChild(window._persistentWebsiteContainer, placeholder);
        }} else {{
            var container = document.createElement('div');
            container.id = 'persistent-website-container';
            container.style.cssText = 'width:100%; margin-top:20px; margin-bottom:20px;';
            
            var iframe = document.createElement('iframe');
            iframe.id = 'persistent-website-iframe';
            iframe.src = '{html.escape(website_url, quote=True).replace("'", "&#39;")}';
            iframe.style.cssText = 'width:100%; height:{website_height_vh}vh; border:1px solid #ccc; border-radius:4px; display:block;';
            iframe.setAttribute('frameborder', '0');
            iframe.setAttribute('allow', 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture');
            iframe.setAttribute('allowfullscreen', '');
            
            container.appendChild(iframe);
            placeholder.parentNode.replaceChild(container, placeholder);
            window._persistentWebsiteContainer = container;
        }}
    }}
}})();
</script>
"""
    
    return website_html

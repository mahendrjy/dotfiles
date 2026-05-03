#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

# Script arguments
FILE_PATH="${1}"
PV_WIDTH="${2}"
PV_HEIGHT="${3}"
IMAGE_CACHE_PATH="${4}"
PV_IMAGE_ENABLED="${5}"

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="${FILE_EXTENSION,,}"

HIGHLIGHT_SIZE_MAX=262143  # 256KiB

handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in
        # Archives
        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
            atool --list -- "${FILE_PATH}" && exit 5
            bsdtar --list --file "${FILE_PATH}" && exit 5
            exit 1;;
        rar)
            unrar lt -p- -- "${FILE_PATH}" && exit 5
            exit 1;;
        7z)
            7z l -p -- "${FILE_PATH}" && exit 5
            exit 1;;

        # PDF
        pdf)
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | fmt -w "${PV_WIDTH}" && exit 5
            mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | fmt -w "${PV_WIDTH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        # OpenDocument
        odt|ods|odp|sxw)
            odt2txt "${FILE_PATH}" && exit 5
            exit 1;;

        # HTML → plain text
        htm|html|xhtml)
            w3m -dump "${FILE_PATH}" && exit 5
            lynx -dump -- "${FILE_PATH}" && exit 5
            elinks -dump "${FILE_PATH}" && exit 5
            ;;

        # JSON — pretty-print
        json)
            jq --color-output . "${FILE_PATH}" && exit 5
            python3 -m json.tool -- "${FILE_PATH}" && exit 5
            ;;

        # CSV
        csv)
            cat "${FILE_PATH}" | column -s, -t | head -n "${PV_HEIGHT}" && exit 5
            ;;
    esac
}

handle_image() {
    local mimetype="${1}"
    case "${mimetype}" in
        image/*)
            local orientation
            orientation="$(identify -format '%[EXIF:Orientation]\n' -- "${FILE_PATH}" 2>/dev/null)"
            if [[ -n "${orientation}" && "${orientation}" != 1 ]]; then
                convert -- "${FILE_PATH}" -auto-orient "${IMAGE_CACHE_PATH}" && exit 6
            fi
            exit 7;;

        video/*)
            ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && exit 6
            exit 1;;
    esac
}

handle_mime() {
    local mimetype="${1}"
    case "${mimetype}" in
        # ── Text files: use bat for syntax highlighting ──────────────
        text/* | */xml | application/javascript | application/json | \
        application/x-sh | application/x-shellscript)
            if [[ "$( stat -f '%z' -- "${FILE_PATH}" 2>/dev/null || stat -c '%s' -- "${FILE_PATH}" )" -gt "${HIGHLIGHT_SIZE_MAX}" ]]; then
                exit 2
            fi
            # bat: syntax highlighted, line numbers, no paging
            bat --color=always \
                --style=numbers,changes \
                --line-range=:"${PV_HEIGHT}" \
                -- "${FILE_PATH}" && exit 5
            # fallback: plain cat
            exit 2;;

        # ── Images: show metadata ────────────────────────────────────
        image/*)
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        # ── Video/audio: show metadata ───────────────────────────────
        video/* | audio/*)
            mediainfo "${FILE_PATH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;
    esac
}

handle_fallback() {
    echo '─── File Info ───────────────────────────────'
    file --dereference --brief -- "${FILE_PATH}" && exit 5
    exit 1
}

MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"
if [[ "${PV_IMAGE_ENABLED}" == 'True' ]]; then
    handle_image "${MIMETYPE}"
fi
handle_extension
handle_mime "${MIMETYPE}"
handle_fallback

exit 1

"""
Quote management for StudyCompanion add-on.
Handles loading quotes from local file and selecting unique quotes.
"""

import os
import random


_quotes_cache: list[str] | None = None


def _load_quotes_from_local() -> list[str]:
    """Load quotes from quotes.txt in the add-on folder (one per line)."""
    try:
        base = os.path.dirname(__file__)
        path = os.path.join(base, "quotes.txt")
        if os.path.exists(path):
            with open(path, "r", encoding="utf-8") as f:
                lines = [l.strip() for l in f.readlines()]
            return [l for l in lines if l]
    except Exception:
        pass
    return []


def get_random_quote() -> str:
    """Return one random motivational quote, using local file then built-in list."""
    global _quotes_cache
    if _quotes_cache is None:
        quotes = _load_quotes_from_local()
        if not quotes:
            quotes = _get_builtin_quotes()
        _quotes_cache = quotes

    if not _quotes_cache:
        return "Keep going — you've got this!"
    return random.choice(_quotes_cache)


def get_unique_random_quotes(count: int) -> list[str]:
    """Return a list of unique random quotes. If count exceeds available quotes, recycle with shuffle."""
    global _quotes_cache
    if _quotes_cache is None:
        get_random_quote()  # Initialize cache

    if not _quotes_cache:
        return ["Keep going — you've got this!"] * count

    if count <= len(_quotes_cache):
        return random.sample(_quotes_cache, count)
    else:
        # If we need more quotes than available, repeat with shuffle
        result = _quotes_cache[:]
        while len(result) < count:
            remaining = count - len(result)
            additional = random.sample(_quotes_cache, min(remaining, len(_quotes_cache)))
            result.extend(additional)
        return result


def _get_builtin_quotes() -> list[str]:
    """Return the built-in collection of motivational quotes."""
    return [
        # Original quotes
        "You can do it!",
        "Keep going — small steps count.",
        "Good job — keep it up!",
        "Focus on progress, not perfection.",
        "Study hard now, succeed later.",
        "One more page, one more step.",
        "Believe in yourself and keep learning.",
        "Practice makes progress.",
        "Stay curious and persistent.",
        "You've got this!",
        "Keep the momentum going.",
        "Just one more card.",
        "Short session, big gains.",
        "Review now, remember later.",
        "Focus for 10 minutes.",
        "Small effort, steady results.",
        "Consistency beats intensity.",
        "Aim for progress today.",
        "Turn knowledge into habit.",
        "You learn a little every day.",
        
        # ADHD-focused study quotes
        "One card closer to your goal!",
        "Your brain is amazing — feed it knowledge.",
        "Micro-wins lead to big victories.",
        "Even 5 minutes counts.",
        "Progress, not perfection.",
        "You're building your future right now.",
        "Every review strengthens your memory.",
        "Small steps = huge leaps.",
        "You're doing better than you think.",
        "Focus on this one card.",
        "Celebrate every small win!",
        "Your effort matters today.",
        "Knowledge is power — you're gaining it.",
        "Keep your streak alive!",
        "You're training your brain.",
        "One more, you're on fire!",
        "Dopamine hit incoming — finish this!",
        "Your focus is your superpower.",
        "Break it down, conquer it.",
        "You're stronger than distractions.",
        "Momentum is building!",
        "Victory loves preparation.",
        "Make your future self proud.",
        "Study now, relax later.",
        "You're investing in yourself.",
        "Small actions, big results.",
        "You're capable of amazing things.",
        "Focus = freedom.",
        "One card at a time wins the race.",
        "You're making neural connections!",
        "Every answer makes you smarter.",
        "Stay present, stay powerful.",
        "Your brain loves this challenge.",
        "Finish strong today!",
        "You're building discipline.",
        "Short bursts = long-term gains.",
        "You're rewiring your brain for success.",
        "Consistency is your secret weapon.",
        "You're leveling up right now.",
        "Focus breeds results.",
        "You're unstoppable today.",
        "Make this session count!",
        "Your effort compounds daily.",
        "Distraction-free = progress.",
        "You're sharpening your mind.",
        "Win the next 10 minutes.",
        "Study = self-respect.",
        "You're in the zone!",
        "One more card = one step closer.",
        "Your brain craves this challenge.",
        "Small wins create big confidence.",
        "You're doing the work others skip.",
        "Focus now, celebrate soon.",
        "You're building unstoppable habits.",
        "Every card = brain gains.",
        "Your future starts with this card.",
        "You're proving yourself today.",
        "Discipline today, freedom tomorrow.",
        "You're making it happen!",
        "Stay locked in — you got this.",
        "Your focus is unmatched right now.",
        "One card closer to mastery.",
        "You're training for excellence.",
        "Small effort, massive impact.",
        "You're building your best self.",
        "Keep the fire burning!",
        "You're in control of your focus.",
        "This session = brain upgrade.",
        "You're outworking your past self.",
        "Focus is your competitive edge.",
        "You're earning your success.",
        "One more rep for the brain!",
        "You're becoming unstoppable.",
        "Study = investing in yourself.",
        "You're making magic happen.",
        "Your grind today = your glory tomorrow.",
        "You're sharper than yesterday.",
        "This is your breakthrough moment.",
        "Focus now, thrive later.",
        "You're building mental muscle.",
        "Every card = one step forward.",
        "You're doing the hard thing.",
        "Laser focus = limitless results.",
        "You're proving doubters wrong.",
        "This card = brain fuel.",
        "You're on your way to greatness.",
        "Momentum starts with one card.",
        "You're building your empire.",
        "Focus is your superpower today.",
        "You're making progress happen.",
        "One more card = one more win.",
        "You're training like a champion.",
        "Your dedication is inspiring.",
        "This session = future success.",
        "You're building the life you want.",
        "Stay focused, stay winning.",
        "You're mastering your craft.",
        "One card closer to your dreams.",
        "You're building mental toughness.",
        "Your effort today = results tomorrow.",
        "You're in beast mode!",
        "Focus now, dominate later.",
        "You're building unstoppable momentum.",
        "Every card = brain evolution.",
        "You're doing what winners do.",
        "This is your power hour.",
        "You're making your brain stronger.",
        "One card = one victory.",
        "You're building your legacy.",
        "Focus is your secret sauce.",
        "You're becoming the best version of you.",
        "This card = future opportunity.",
        "You're training for excellence.",
        "Your focus is your fortune.",
        "One more card = one more breakthrough.",
        "You're building unstoppable confidence.",
        "This session = brain training.",
        "You're making it look easy!",
        "Focus today = freedom tomorrow.",
        "You're creating your success story.",
        "One card closer to mastery level.",
        "You're building mental excellence.",
        "Your dedication is unmatched.",
        "This is your winning moment.",
        "You're making progress every second.",
        "One more card = one more level up.",
        "You're building the future you want.",
        
        # Manifestation & Affirmation Quotes
        
        # Self-Worth & Identity
        "I am enough, exactly as I am.",
        "I deserve all the good things coming my way.",
        "I am worthy of love, success, and happiness.",
        "My value doesn't decrease based on others' opinions.",
        "I am confident in who I am becoming.",
        "I trust myself and my decisions.",
        "I am proud of how far I've come.",
        "I accept myself fully and unconditionally.",
        "I am deserving of my dreams.",
        "I am powerful beyond measure.",
        
        # Mental Health & Emotional Balance
        "I am calm, centered, and at peace.",
        "I release all anxiety and embrace tranquility.",
        "I choose peace over worry.",
        "I am in control of my thoughts.",
        "I let go of what I cannot control.",
        "I am safe, supported, and loved.",
        "I trust the timing of my life.",
        "I am resilient and strong.",
        "I honor my emotions without judgment.",
        "I create space for joy and peace.",
        
        # Physical Health & Energy
        "I am healthy, strong, and energized.",
        "My body is a temple of vitality.",
        "I nourish my body with love and care.",
        "I am grateful for my body's strength.",
        "I choose foods that energize me.",
        "I am radiating health and wellness.",
        "My body heals quickly and naturally.",
        "I am full of energy and vitality.",
        "I honor my body with movement.",
        "I am getting stronger every day.",
        
        # Abundance & Financial Freedom
        "I am a magnet for abundance.",
        "Money flows to me easily and effortlessly.",
        "I am worthy of financial freedom.",
        "I attract wealth in all forms.",
        "I am open to receiving abundance.",
        "I deserve to be financially secure.",
        "My income is constantly increasing.",
        "I am aligned with the energy of prosperity.",
        "I create abundance with my thoughts.",
        "I am grateful for my financial blessings.",
        
        # Career, Purpose & Productivity
        "I am aligned with my life's purpose.",
        "I am doing work I love and loving the work I do.",
        "I am productive, focused, and efficient.",
        "I attract success in my career.",
        "I am worthy of career advancement.",
        "I am fulfilling my purpose every day.",
        "I am a valuable asset to my team.",
        "I am confident in my professional abilities.",
        "I create opportunities for success.",
        "I am motivated and driven.",
        
        # Gratitude & Appreciation
        "I am grateful for all that I have.",
        "I appreciate the beauty in every moment.",
        "I am thankful for my journey.",
        "I am blessed beyond measure.",
        "I am grateful for my growth.",
        
        # Relationships & Love
        "I am worthy of healthy, loving relationships.",
        "I attract positive, supportive people.",
        "I am surrounded by love and kindness.",
        "I am deserving of deep connection.",
        "I am loved and appreciated.",
        
        # Growth, Learning & Discipline
        "I am committed to my personal growth.",
        "I am always learning and evolving.",
        "I am disciplined and focused.",
        "I am becoming better every day.",
        "I am dedicated to my goals.",
        
        # Peace, Presence & Spiritual Alignment
        "I am at peace with myself.",
        "I am present in this moment.",
        "I am aligned with my higher self.",
        "I am spiritually grounded.",
        "I am in harmony with the universe.",
    ]

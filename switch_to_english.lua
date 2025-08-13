-- Quick script to switch OTClient to English language
-- Run this script in the OTClient terminal or save it as a module

print("Switching to English language...")

-- Set the locale to English
g_settings.set('locale', 'en')

-- Force reload the locale
if modules.client_locales then
    if modules.client_locales.setLocale then
        modules.client_locales.setLocale('en')
        print("Language switched to English successfully!")
    else
        print("Error: Locale module not available")
    end
else
    print("Error: Locales module not loaded")
end

-- You may need to restart the client for changes to take full effect
print("Note: You may need to restart the client for all changes to take effect.")

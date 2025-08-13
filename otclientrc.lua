-- this file is loaded after all modules are loaded and initialized
-- you can place any custom user code here

-- Set default configuration for Tibia 7.72
g_settings.set('client-version', 772)
g_settings.set('host', '35.199.75.222')
g_settings.set('port', 7171)

-- Force English locale
g_settings.set('locale', 'en')

print 'Startup done :]'
print 'Default server set to: 35.199.75.222:7171 (Tibia 7.72)'
print 'Language set to: English'


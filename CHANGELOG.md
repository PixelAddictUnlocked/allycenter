# Changelog

All notable changes to Ally Center will be documented in this file.

## Unreleased

### New Features

- Added an optional Download Mode toggle to prevent idle sleep, suspend, and hibernation while downloads are running

### Bug Fixes

- Fixed the Charge Limit slider, which silently did nothing on the ROG Ally X — it wrote to an `asus-nb-wmi` platform path that does not exist on the device, skipped the write, and reported success anyway
- Charge Limit now writes to the real attribute (`/sys/class/power_supply/BAT*/charge_control_end_threshold`, registered by the `asus_wmi` battery hook), reads it back to confirm it stuck, and reports the control as unavailable when no attribute is present
- Charge Limit now displays the live value from the hardware instead of a possibly stale saved setting
- Removed a duplicate `set_charge_limit` definition that silently shadowed the first

## [1.1.0] - 2026-01-03

### New Features

- Added RGB speed slider - control how fast animated effects run (Pulse, Spectrum, Wave, Flash)
- Added CPU Settings section with SMT and CPU Boost toggles

### Bug Fixes

- Fixed fan presets - Quiet, Balanced, and Performance now work correctly
- Fixed RGB Battery Level effect to properly show green (full) to red (empty)

### Improvements

- Cleaner popup dialogs for Device Info and About screens
- Added release automation script for developers

### Removed

- Removed Controller section (gyroscope and vibration were not functional)

---

## [1.0.0] - Initial Release

### Features

- **RGB Lighting** - Color picker, brightness control, and animated effects
- **Battery Health** - Monitor battery status and set charge limits
- **Performance Profiles** - Quick TDP presets (Silent, Balanced, Turbo, Max)
- **Fan Control** - Choose between Quiet, Balanced, Performance, or Auto
- **Download Mode** - Turn off screen while downloading games
- **Device Info** - View hardware and system information
- **Persistent Settings** - All settings saved across reboots

# JEEFRY PC Cleaner

A simple, portable Windows batch tool that cleans junk and speeds up slow computers. Run it straight from a USB drive, pick an option from the menu, done. No installation needed.

Made by **JEEFRY**

## Screenshots

| Main menu | Running an option |
|-----------|-------------------|
| ![Main menu](sc1.jpg) | ![Running an option](sc2.jpg) |

## Features

| Option | What it does |
|--------|--------------|
| **1. Clean Temporary Storage** | Clears user temp, local temp, Windows temp, Prefetch, and recent file lists |
| **2. Windows Disk Cleanup** | Runs the built-in Disk Cleanup automatically with every category selected |
| **3. Flush DNS and Reset Network Cache** | Flushes DNS, clears ARP and NetBIOS caches, resets Winsock |
| **4. Enable Performance Mode** | Switches to the Ultimate/High Performance power plan, turns off transparency, animations and Game DVR |
| **5. Deep Junk Cleanup** | Clears Chrome, Edge and Firefox caches, thumbnails, error reports, logs, Windows Update cache, and empties the Recycle Bin |
| **6. Repair System Files** | Runs DISM and SFC to repair corrupted Windows files |

You choose what runs. Nothing happens until you press a number.

## How to use

1. Download `JEEFRY_PC_Cleaner.bat` (or clone this repo) and copy it to your USB drive.
2. On the target PC, **right-click** the file and choose **Run as administrator**.
3. Type a number from `0` to `6` and press Enter.
4. When it finishes, press any key to return to the menu.

## Requirements

- Windows 10 or Windows 11
- Administrator rights

## Notes

- Close your web browsers before running option 5 so their caches clear fully.
- Option 5 empties the Recycle Bin without asking. Check it first if you need anything in there.
- Option 3 resets Winsock, so restart the PC afterwards to fully apply it.
- Option 6 can take 10 to 30 minutes. Don't close the window while it runs.
- Use at your own risk. Always make sure important files are backed up before running system tools on someone else's computer.

## License

Free to use and share. Please keep the credit to **JEEFRY**.

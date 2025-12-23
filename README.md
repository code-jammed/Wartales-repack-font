# Wartales-repack-font

A tool to repack fonts for the game Wartales.
It is assumed that you have already updated the localization files.


## manually download dependencies before running

### folder: `_tools_`

1. `fontgen\fontgen.exe` and its dependencies
   - [Fontgen V1.1.0](https://github.com/Yanrishatum/fontgen/releases/tag/1.1.0)
   - expected SHA256: `8E68482A506320B1AD509FD5E5AB885C571FD6845B60E593E2B923CD48F23D0D`

2. `txt2fnt\txt2fnt.exe` and its dependencies
   - [txt2fnt](https://github.com/code-jammed/txt2fnt)

3. `quickbms\quickbms.exe` & `quickbms\quickbms_4gb_files.exe` and their dependencies
   - [QuickBMS](https://aluigi.altervista.org/quickbms.htm)

4. Place your desired TTF font files in the `_tools_/ttf` folder.




# Wartales_repack_font

### `Wartales_repack_font.py` will:

1. check if working directories contain necessary files for next step:
   - `_tools_/quickbms/quickbms.exe`
2. empty the folder `workspace/extracted-res/` and
   use `quickbms.exe` to
   extract i18n files from Wartales res.pak into `workspace/extracted-res/`
   - e.g. expected files (under the folder):
      1. `lang/texts_zh.xml`
      2. `lang/export_zh.xml`
3. empty the folder `workspace/extracted-txt/` and
   copy all extracted files into `workspace/extracted-txt/` (no subdirs)
   - e.g. expected files (under the folder):
      1. `texts_zh.xml`
      2. `export_zh.xml`
4. check if working directories contain necessary files for next step:
   - `_tools_/fontgen/fontgen.exe`
   - `_tools_/txt2fnt/txt2fnt.exe`
   - `_tools_/ttf/**.ttf`
5. use `txt2fnt.exe` to convert the xml files into fnt files
   - e.g. expected command:

      `txt2fnt.exe -tf workspace/extracted-txt -fs 48 -ttf ChironHeiHK-Text-R-400 -o noto_sans_cjk_regular -ff workspace/modded-assets/ui/fonts`
   and check expected output files exist:
      1. `workspace/modded-assets/ui/fonts/noto_sans_cjk_regular.fnt`
      2. `workspace/modded-assets/ui/fonts/noto_sans_cjk_regular.png`
6. use `quickbms_4gb_files.exe` to repack the modified font files into `assets.pak`
   - e.g. expected command:

      `_tools_/quickbms_4gb_files.exe -w -r -r _script_/script-v2.bms ./assets.pak ./workspace/modded-assets`




### testing example

```bash
py -m source.example.test_extract
```


# Build executables
```bash
./build_exe.ps1
```

## build GUI only
```bash
pyinstaller --onefile --windowed Wartales_repack_font_gui.py
```


## run the GUI for debugging
```bash
py -m Wartales_repack_font_gui --debug
```

# Wartales 戰爭傳說 — 中文字體重注與翻譯導入指南

1. **解壓縮**
   將 **`Wartales-戰爭傳說-重注中文字體工具.zip`** 解壓縮至遊戲資料夾（即 `Wartales.exe` 所在位置）。

2. **準備翻譯文本**
   本工具 **不提供翻譯文本**，請自行準備。
   - 在遊戲資料夾中建立 `_new_xml_` 資料夾。
   - 將翻譯文本（XML 格式）放入該資料夾。
   - 檔案命名規則：
     - `texts_語言代碼.xml`
     - `export_語言代碼.xml`
     - 範例：`texts_zh.xml`、`export_zh.xml`

   **正確的資料夾與檔案結構：**
   ```
   Wartales.exe
   _new_xml_/texts_zh.xml
   _new_xml_/export_zh.xml
   ```

3. **執行工具**
   開啟 **`Wartales_repack_font_gui.exe`**，進入圖形介面。

4. **選擇字體**
   在介面中選擇欲使用的字體大小與 TTF（字型家族 + 粗細）。

5. **開始重打包**
   點擊 **「注入新翻譯 及 重新生成字體」** 按鈕，即可開始重新打包流程。


# Wartales – Repack Chinese Font & Translation Guide (English)

1. **Unzip** `Wartales-戰爭傳說-重注中文字體工具.zip` into the game folder (the same location as `Wartales.exe`).

2. **Prepare your translation files** (this tool does not provide translations).
   - Create a folder named `_new_xml_` inside the game directory.
   - Place your translation files (in XML format) inside `_new_xml_`.
   - File naming rules:
     - `texts_<language code>.xml`
     - `export_<language code>.xml`
     - Example: `texts_zh.xml` and `export_zh.xml`

   **Expected folder & file structure:**
   ```
   Wartales.exe
   _new_xml_/texts_zh.xml
   _new_xml_/export_zh.xml
   ```

3. **Run** `Wartales_repack_font_gui.exe` to open the graphical interface.

4. **Select** the font size and TTF (font family + weight) you want to use.

5. **Click** the button **“注入新翻譯 及 重新生成字體”** (“Inject New Translation & Repack Font”) to start the repacking process.

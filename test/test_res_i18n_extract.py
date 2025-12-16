import shutil
import unittest
import os

from source.util.res_i18n_extractor import extract_i18n


class TestExtractLocalization(unittest.TestCase):
    def setUp(self):
        self.root = os.getcwd()
        self.input_archive = os.path.join("test_data", "res.pak")
        self.output_dir = os.path.join("workspace", "extracted-res")
        # ensure a clean output dir
        if os.path.exists(self.output_dir):
            shutil.rmtree(self.output_dir)
        os.makedirs(self.output_dir, exist_ok=True)
        self.filters = ["lang/texts_zh.xml", "lang/export_zh.xml"]

    def test_list_files(self):
        # Ensure files are present by extracting first, then list-only should
        # return True (it checks for presence of extracted files).
        ok = extract_i18n(
            language="zh",
            res_pak=self.input_archive,
            list_only=False,
            verbose=False,
        )
        self.assertTrue(ok, msg="extract_i18n failed to extract files")

        ok_list = extract_i18n(
            language="zh",
            res_pak=self.input_archive,
            list_only=True,
            verbose=False,
        )
        self.assertTrue(ok_list, msg="list-only did not detect extracted files")

    def test_extract_files(self):
        ok = extract_i18n(
            language="zh",
            res_pak=self.input_archive,
            list_only=False,
            verbose=False,
        )
        self.assertTrue(ok, msg="extract_i18n failed to extract files")
        for f in self.filters:
            expected = os.path.join(self.output_dir, f)
            self.assertTrue(os.path.exists(expected), msg=f"Extracted file missing: {expected}")

    def test_invalid_language(self):
        with self.assertRaises(ValueError):
            extract_i18n(
                language="../",
                res_pak=self.input_archive,
                list_only=True,
                verbose=False,
            )


if __name__ == "__main__":
    unittest.main()

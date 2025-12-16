"""Simple runner to extract localization files from test_data/res.pak.

This is not a unit test — it performs an extraction and prints the results,
leaving files in `workspace/extracted-res/`.
"""
import os
import sys

from source.util.res_i18n_extractor import extract_i18n


res_pak = "test_data/res.pak"
if not os.path.exists(res_pak):
    print(f"Archive not found: {res_pak}")
    sys.exit(1)

isAllExtracted = extract_i18n(
    language="zh",
    res_pak=res_pak,
    list_only=False,
    verbose=False,
)

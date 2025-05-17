#!/usr/bin/env python3
import os
import subprocess
from pathlib import Path
import deploy_defines   # provides base_dir

# --------------------------------------------------------------------------- #
# config – adjust these once and they apply to every package build
# --------------------------------------------------------------------------- #
DOC_ROOT          = Path("build/html/doc/rosdoc2")
CROSS_REF_DIR     = DOC_ROOT / "cross_reference"
DOCS_OUTPUT_DIR   = DOC_ROOT / "docs_output"
DOCS_BUILD_DIR    = DOC_ROOT / "docs_build"

def find_ros2_package_paths(root: str | Path) -> list[Path]:
    root = Path(root).resolve()
    return [
        Path(r)
        for r, _d, files in os.walk(root)
        if "package.xml" in files
    ]

def build_docs(package_paths: list[Path]) -> None:
    # make sure the three target directories exist
    for p in (CROSS_REF_DIR, DOCS_OUTPUT_DIR, DOCS_BUILD_DIR):
        p.mkdir(parents=True, exist_ok=True)

    for pkg_path in package_paths:
        cmd = [
            "rosdoc2", "build",
            "--package-path", str(pkg_path),
            "-c", str(CROSS_REF_DIR),      # cross-reference output
            "-o", str(DOCS_OUTPUT_DIR),    # final HTML output
            "-d", str(DOCS_BUILD_DIR),     # sphinx build dir
        ]
        print(f"[rosdoc2] {pkg_path}")
        try:
            subprocess.run(cmd, check=True)
        except subprocess.CalledProcessError as e:
            print(f"  ❌  failed: {e}")

def main() -> None:
    os.chdir(deploy_defines.base_dir)
    pkgs = find_ros2_package_paths("doc")
    if not pkgs:
        print("No packages found.")
        return
    build_docs(pkgs)

if __name__ == "__main__":
    main()

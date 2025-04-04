# Copyright (c) 2023 ros2_control maintainers
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
import shutil

# This file includes all the definitions used in the other scripts
script_base_dir = os.path.dirname(os.path.abspath(__file__))
# should be control.ros.org folder
base_dir = os.path.dirname(script_base_dir)
# branch from which is started to checkout other branches
if os.environ.get('BASE_BRANCH_PR') is not None:
  base_branch = os.environ.get('BASE_BRANCH_PR')
elif os.environ.get('BASE_BRANCH') is not None:
  base_branch = os.environ.get('BASE_BRANCH')
else:
  base_branch = "humble"
print(f"Using base_branch: {base_branch}")

build_dir = "build"

# pr stats
pr_stats_files = [
    "reviewers_maintainers_stats_recent.html",
    "reviewers_stats_recent.html",
    "reviewers_maintainers_stats.html",
    "reviewers_stats.html",
    "contributors_maintainers_stats_recent.html",
    "contributors_stats_recent.html",
    "contributors_maintainers_stats.html",
    "contributors_stats.html"
]

# definitions for multiversion
# branches on which the temporary commits are created
# {"branch checked out for multiversion": "branch checked out for all subrepos with maps below"}
branch_version = {
    "humble": "humble",
    base_branch: "humble"  # PRs are tested on rolling
}


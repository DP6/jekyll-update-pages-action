#!/bin/bash
# Copyright 2021 DP6 Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

username=$1
token=$2
filter=$3

# List of all repositories matching filter.
repos_response=$(curl "https://api.github.com/search/repositories?q=${filter}" -H "Accept: application/vnd.github.v3+json")
output=$(jq '.items[] | select(.homepage != null) | {full_name, homepage}' <<< "$repos_response")

jq '.' <<< "$output"

jq -r '.full_name' <<< "$output" | while read repo; do
  echo "Update gh-pages $repo"

  # Deploy GitHub pages
  curl -u "$username:$token" \
    -X POST "https://api.github.com/repos/$repo/pages/builds" \
    -H "Accept: application/vnd.github.mister-fantastic-preview+json" \
    | jq '.'
done

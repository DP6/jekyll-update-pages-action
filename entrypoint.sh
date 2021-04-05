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

# List of all repositories with org = DP6 and public
output=$(curl   -H "Accept: application/vnd.github.v3+json"   https://api.github.com/search/repositories?q=$filter | jq '.[]' | jq '[.[] | select(.homepage != null) | {name: .name, homepage:.homepage}]')

echo "::set-output name=search-result::"$($output | jq '.')

for row in $(echo "${output}" | jq -r '.[] | @base64'); do
    _jq() {
     echo ${row} | base64 --decode | jq -r ${1}
    }

    repo=$(_jq '.name')

   echo "Update gh-pages $repo"
   # Deploy Github pages
   response=$(curl -u $username:$token -X POST https://api.github.com/repos/dp6/$repo/pages/builds -H "Accept: application/vnd.github.mister-fantastic-preview+json")
   echo "::set-output name=update-gh-pages::"$($response | jq '.')
done
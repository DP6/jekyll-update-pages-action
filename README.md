# jekyll-update-pages-action

<div align="center">
  <img src="https://raw.githubusercontent.com/DP6/templates-centro-de-inovacoes/main/public/images/centro_de_inovacao_dp6.png" height="100px" />
</div>

<p align="center">
  <a href="#badge">
    <img alt="semantic-release" src="https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg">
  </a>
  <a href="https://www.codacy.com/gh/DP6/jekyll-update-pages-action/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=DP6/jekyll-update-pages-action&amp;utm_campaign=Badge_Grade">
    <img src="https://app.codacy.com/project/badge/Grade/1a3f49bd2ffe4be29af8dec3cef0f5ef"/>
  </a>
</p>

Action to update one or more repos which have GitHub Pages enabled - without generating a new commit.

## Table of Contents

- [Usage](#usage)
- [Inputs](#inputs)
- [Example Workflows](#example-workflows)

## Usage

The example here will run at 0:30 daily to update all GitHub Pages sites available in the [DP6](https://github.com/DP6) which are public repos.

### Prerequisites

- [Creating a personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)
- [Choose search filters](https://docs.github.com/en/rest/reference/search#search-repositories)
- [Encode the filter](https://www.url-encode-decode.com/)

```yaml
name: Update all GitHub Pages sites

on:
  schedule:
    - cron: "30 0 * * *"

jobs:
  github-pages:
    runs-on: ubuntu-latest
    name: Update GitHub Pages initiatives
    steps:
      - name: Jekyll update github pages without new commit
        uses: DP6/jekyll-update-pages-action@v1.0.1
        with:
          DEPLOY_TOKEN: ${{ secrets.GH_PAGES_DEPLOY_TOKEN }}
          USER: ${{ secrets.GH_PAGES_USER }}
          FILTER: "is%3Apublic%20org%3Adp6"
```

## Inputs

| Name           | Requirement | Default                   | Description                                        |
| -------------- | ----------- | ------------------------- | -------------------------------------------------- |
| `DEPLOY_TOKEN` | required    |                           | Personal Access Token for accessing GitHub API     |
| `USER`         | required    |                           | Username of the owner of the Personal Access Token |
| `FILTER`       | optional    | `is%3Apublic%20org%3Adp6` | Find repositories matching this filter             |

<br/>

## Example Workflows

The [dp6.github.io](https://dp6.github.io?utm_medium=README&utm_source=github&utm_campaign=gitacion) website is built with Jekyll and serves as a theme for the other repositories of the DP6 organization on github.

<img alt="Architecture dp6.github.io" src="https://github.com/DP6/templates-centro-de-inovacoes/raw/main/public/images/dp6-gh-pages-architecture.png">

## How to contribute

Pull requests are welcome! We will love help to evolve this module. Feel free to browse open issues looking for something you can do. If you have a new feature or bug, please open a new issue to be followed up by our team.

### Mandatory requirements

Only contributions that meet the following requirements will be accepted:

- [Commit pattern](https://www.conventionalcommits.org/en/v1.0.0/)

## Support:

**DP6 Koopa-troopa Team**

_e-mail: <koopas@dp6.com.br>_

<img src="https://raw.githubusercontent.com/DP6/templates-centro-de-inovacoes/main/public/images/koopa.png" height="100" />

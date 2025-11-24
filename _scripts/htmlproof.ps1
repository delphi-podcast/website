bundle exec jekyll build --incremental
bundle exec htmlproofer ./_site --no-enforce-https *>&1 > _scripts/htmlproofer_report.txt

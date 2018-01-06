#!/bin/sh
grep 'url' .gitmodules | awk -F "[/.]" '{printf("wget https://codeload.github.com/%s/%s/zip/master -O %s.zip\n", $5, $6, $6)}' | while read line
do
	echo $line
	`$line`
done


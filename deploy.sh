if [ "$1" = "-i" ]
then
    mkdir output
    cd output
    git clone -b gh-pages git@github.com:RbingChen/wiki.git ./
    cd ..
    exit 0
elif [ "$1" = "" ]
then
    sh /Users/bing/Wiki/copy.sh 
    echo deploy [Option]
    echo "       -i 初始化"
    echo "       message  提交到github并发布，提交信息为mesage"
    exit 0
else
    git add . --all
    git commit -am "$1"
    git pull --depth=1 origin master
    git push origin master

    simiki g
    cd output
    mkdir src
    cp ../src/*.html src/
    cp ../src/*/*.html src/
    git add . --all
    git commit -am "$1"
    git pull --depth=1 origin gh-pages
    git push origin gh-pages
    cd ..
fi
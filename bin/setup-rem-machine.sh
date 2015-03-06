#!/bin/sh

if [ "$1" == "" ]; then
	echo "Usage: setup-rem-machine.sh <host>"
	echo "       Clone env to host and set up ssh keys there"
	exit 1
fi

base_host="`hostname`.`domainname`"
remote=$1

pushd `pwd`/..
my_env_dir=`pwd`
popd

pushd ~
my_home_dir=`pwd`
popd

echo ""
echo "Generating key on localhost"
echo ""

if [ ! -f ~/.ssh/id_rsa.pub ]; then
	ssh-keygen -t rsa -f ~/.ssh/id_rsa
fi
pub_key=`cat ~/.ssh/id_rsa.pub`

echo ""
echo "Generating key on $remote"
echo ""

ssh $remote << EOF
if [ ! -f ~/.ssh/id_rsa.pub ]; then
	ssh-keygen -t rsa -f ~/.ssh/id_rsa
fi
EOF

echo ""
echo "Authorizing localhost on $remote:"
echo ""
echo $pub_key
echo ""

cmd="echo '$pub_key' >> ~/.ssh/authorized_keys"
ssh $remote $cmd

rem_pub_key=`ssh $remote 'cat ~/.ssh/id_rsa.pub'`

echo ""
echo "Authorizing $remote on localhost:"
echo ""
echo $rem_pub_key
echo ""

echo $rem_pub_key >> ~/.ssh/authorized_keys


echo ""
echo "Cloning: $base_host:$my_env_dir"
echo ""

echo " Run this and exit when done"
echo ""
echo "   git clone -b master $base_host:$my_env_dir"
echo ""
ssh $remote

ssh $remote 'pushd ~/z_myEnv; ./setup.sh'

cmd="echo 'GIT_HOME=$base_host:$my_home_dir' >> ~/.git-home-base"
ssh $remote $cmd



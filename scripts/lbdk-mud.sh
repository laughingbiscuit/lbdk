#!/bin/bash
tmux has-session -t mud
if [ $? != 0 ]
then
  tmux new-session -s mud -n "play" -d
  tmux send-keys -t mud:0.0 'tt++' C-m
  tmux send-keys -t mud:0.0 "#ses x aardmud.org 23;$(lpass show -u Aardwolf);$(lpass show -p Aardwolf)" C-m
  
fi
tmux attach -t mud

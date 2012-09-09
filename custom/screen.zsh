# screen のステータスバーに現在実行中のコマンドを表示
# cd をしたときにlsを実行する
# ref. http://nijino.homelinux.net/diary/200206.shtml#200206140
if [ "$TERM" = "screen" ]; then
chpwd () {
    _set_env_git_current_branch
    _update_rprompt
    echo -n "_`dirs`\\"
    ls
}
preexec() {
# see [zsh-workers:13180]
# http://www.zsh.org/mla/workers/2000/msg03993.html
    emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
        fg)
        if (( $#cmd == 1 )); then
            cmd=(builtin jobs -l %+)
        else
            cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
    %*) 
        cmd=(builtin jobs -l $cmd[1])
        ;;
    cd)
        if (( $#cmd == 2)); then
            cmd[1]=$cmd[2]
                fi
                ;&
                *)
                echo -n "k$cmd[1]:t\\"
                return
                ;;
    esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
                cmd=(${(z)${(e):-\$jt$num}})
                echo -n "k$cmd[1]:t\\") 2>/dev/null
}
chpwd
fi

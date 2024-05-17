#!/bin/bash


board=("1" "2" "3" "4" "5" "6" "7" "8" "9")


display_board() {
    echo " ${board[0]} | ${board[1]} | ${board[2]} "
    echo "---+---+---"
    echo " ${board[3]} | ${board[4]} | ${board[5]} "
    echo "---+---+---"
    echo " ${board[6]} | ${board[7]} | ${board[8]} "
}


check_win() {

    for i in 0 3 6; do
        if [[ ${board[$i]} == ${board[$i+1]} && ${board[$i+1]} == ${board[$i+2]} ]]; then
            return 0
        fi
    done
    for i in 0 1 2; do
        if [[ ${board[$i]} == ${board[$i+3]} && ${board[$i+3]} == ${board[$i+6]} ]]; then
            return 0
        fi
    done
    if [[ ${board[0]} == ${board[4]} && ${board[4]} == ${board[8]} ]]; then
        return 0
    fi
    if [[ ${board[2]} == ${board[4]} && ${board[4]} == ${board[6]} ]]; then
        return 0
    fi
    return 1
}


check_draw() {
    for i in "${board[@]}"; do
        if [[ $i != "X" && $i != "O" ]]; then
            return 1
        fi
    done
    return 0
}


current_player="X"
while true; do
    clear
    display_board
    echo "Player $current_player, enter your move (1-9): "
    read -r move


    if [[ $move =~ ^[1-9]$ ]] && [[ ${board[$((move-1))]} != "X" && ${board[$((move-1))]} != "O" ]]; then
        board[$((move-1))]=$current_player
    else
        echo "Invalid move, try again."
        sleep 1
        continue
    fi


    if check_win; then
        clear
        display_board
        echo "Player $current_player wins!"
        break
    fi


    if check_draw; then
        clear
        display_board
        echo "It's a draw!"
        break
    fi


    if [[ $current_player == "X" ]]; then
        current_player="O"
    else
        current_player="X"
    fi
done

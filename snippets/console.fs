// handle Ctrl+C
Console.CancelKeyPress.AddHandler(fun _ _ ->
    Console.message "Close on exit ..."
)
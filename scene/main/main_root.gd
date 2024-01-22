class_name MainRoot
extends Node2D


@onready var _ref_InitWorld: InitWorld = $InitWorld
@onready var _ref_PlayerInput: PlayerInput = $PlayerInput
@onready var _ref_Sidebar: CustomMarginContainer = $Sidebar
@onready var _ref_Schedule: Schedule = $Schedule


func _ready() -> void:
    _connect_signals(SignalData.SIGNAL_CONNECTIONS)

    _ref_InitWorld.create_world()
    _ref_PlayerInput.set_process_unhandled_input(true)
    _ref_Sidebar.init_gui()
    _ref_Schedule.start_first_turn()

    VisualEffect.set_background_color()
    VisualEffect.set_indicator_color()


func _connect_signals(signal_connections: Dictionary) -> void:
    var signals_from_one_node: Dictionary
    var target_nodes: Array
    var source_signal: Signal
    var target_function: Callable

    for source_node: String in signal_connections.keys():
        signals_from_one_node = signal_connections[source_node]

        for signal_name: String in signals_from_one_node.keys():
            target_nodes = signals_from_one_node[signal_name]

            for target_node: String in target_nodes:
                source_signal = get_node(source_node)[signal_name]
                target_function = get_node(target_node)["_on_" +
                        source_node.replace("/root/", "") + "_" + signal_name]

                if source_signal.connect(target_function) == \
                        ERR_INVALID_PARAMETER:
                    push_error("Signal error: %s -> %s, %s." %
                            [source_node, target_node, signal_name])

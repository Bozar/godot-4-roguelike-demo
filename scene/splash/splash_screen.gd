class_name SplashScreen
extends CustomMarginContainer


@onready var _ref_WelcomeLabel: WelcomeLabel = $WelcomeLabel


func _ready() -> void:
    init_gui()


func init_gui() -> void:
    _ref_WelcomeLabel.init_gui()


func _on_PlayerInput_action_pressed(input_tag: StringName) -> void:
    if input_tag == InputTag.START_GAME:
        visible = false

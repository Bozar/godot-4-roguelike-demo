class_name Sidebar
extends CustomMarginContainer


@onready var _ref_GameStateLabel: CustomLabel = $SidebarVBox/GameStateLabel
@onready var _ref_FootnoteLabel: CustomLabel = $SidebarVBox/FootnoteLabel


func init_gui() -> void:
    _ref_GameStateLabel.init_label()
    _ref_FootnoteLabel.init_label()


func _on_Schedule_turn_started(sprite: Sprite2D) -> void:
    if sprite.is_in_group(SubTag.PC):
        _ref_GameStateLabel.update_label()

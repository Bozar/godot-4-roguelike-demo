class_name Sidebar
extends CustomMarginContainer


@onready var _ref_GameStateLabel: CustomLabel = $SidebarVBox/GameStateLabel
@onready var _ref_FootnoteLabel: CustomLabel = $SidebarVBox/FootnoteLabel


func init_gui() -> void:
    _ref_GameStateLabel.init_label()
    _ref_FootnoteLabel.init_label()

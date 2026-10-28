extends Node2D

const COLOR_ORDER := ["red", "yellow", "blue"]
const MIXED_COLOR_ORDER := ["orange", "green", "purple"]
const POWERUP_BOMB_COLOR_ORDER := ["red", "yellow", "blue"]
const PERFECT_PRAISE_TEXTS := ["Bulls' Eye", "Nice Shot", "Incredible", "Touchez", "Perfect"]
const PERFECT_PRAISE_TEXTS_ZH := ["夯", "漂亮", "帅", "牛", "厉害"]
const COLOR_WORDS_ZH := {
	"red": "红", "yellow": "黄", "blue": "蓝",
	"orange": "橙", "green": "绿", "purple": "紫",
}
const SPECIAL_WORDS_ZH := {
	"crystal": "水晶球", "antimatter": "反物质", "missile": "导弹",
}
const ZH_TEXTS := {
	"CONTINUE": "继续游戏",
	"NEW GAME": "新游戏",
	"SELECT LEVEL": "选择关卡",
	"SETTING": "设置",
	"Level ": "关卡 ",
	"Coins ": "金币 ",
	"SETTINGS": "设置",
	"VOLUME": "音量",
	"BACK": "返回",
	"OK": "确定",
	"Lv%d  T:%d  S:%d/%d  P:%d": "关%d  目标%d  发%d/%d  直%d",
	"T:": "目标",
	"S:": "出手",
	"P:": "完美",
	"FURBALL": "粉毛",
	"PINK FURBALL": "粉毛球",
	"One giant furball for your next shot.": "下一发变成一颗巨大粉毛球。",
	"It destroys ANYTHING it touches.": "它摧毁碰到的一切。",
	"Ignores shields, spikes, HP and black holes.": "无视护盾、尖刺、生命与黑洞。",
	"Its 6s fuse starts on the first target hit,": "首次撞到目标起倒数 6 秒，",
	"then it bursts into a cloud of pink smoke.": "时间一到炸成漫天粉雾。",
	"Furball armed - fire when ready!": "粉毛球已就绪——随时发射！",
	"A furball is already on the loose!": "已有一颗粉毛球在场上撒欢！",
	"Furball armed - your next shot!": "粉毛球已就绪——就在下一发！",
	"READY": "就绪",
	"STOP": "冻结",
	"CRYSTAL": "水晶",
	"MSL": "导弹",
	"LEVEL CLEAR!": "恭喜过关！",
	"PAUSED": "已暂停",
	"Cost $%d": "花费 $%d",
	"Use it now?": "立即使用？",
	"CONFIRM": "确认",
	"%s cancelled - $%d back.": "%s已取消，返还 $%d。",
	"BASE": "基础",
	"PERFECT": "完美",
	"SHOTS LEFT": "剩余出手",
	"COINS": "金币",
	"BALANCE ": "余额 ",
	"TAP FOR NEXT": "点按进入下一关",
	"TAP TO CONTINUE": "点按继续",
	"DEMO COMPLETE!": "试玩版通关！",
	"You've cleared the POP'EM! demo. Thank you for playing!": "您已通关彩弹爆爆试玩版，感谢支持！",
	"The full version is coming soon. Stay tuned!": "正式版近日即将上市，敬请期待。",
	"Release %s %s": "松手发射 %s（%s色）",
	"Release %s  |  Power %d%%": "松手发射 %s ｜ 力度 %d%%",
	"Release to fire  |  Power %d%%": "松手发射 ｜ 力度 %d%%",
	"No shots left - watch the board": "出手用完，观察球局",
	"Pull a color to fire %s": "拉任意颜色球发射%s",
	"Black hole returns in %ds": "黑洞 %d 秒后回归",
	"Release for single %s, or hold two colors.": "松手发射单个%s，或按住两种颜色。",
	"Hold two colors to mix.": "按住两种颜色进行混色。",
	"Release both colors together.": "两指同时松开。",
	"OUT OF SHOTS": "出手用完",
	"All shots are used up.": "出手次数已经用完。",
	"Buy +%d shots for $%d": "购买 +%d 次出手（$%d）",
	"and keep popping?": "继续闯关？",
	"Extra shots cost $%d.": "补充出手需要 $%d。",
	"Not enough coins - retry!": "金币不足，重打本关！",
	"BUY +%d": "购买 +%d",
	"RETRY": "重试",
	"+%d shots bought.": "已购买 +%d 次出手。",
	"Pull down farther, then release.": "往下拉得更远些再松手。",
	"Pull %s down/sideways": "把%s色球向下或侧向拉",
	"%s first.": "先%s。",
	"Choose two different colors.": "请选择两种不同的颜色。",
	"Use two colors at once.": "需要同时使用两种颜色。",
	"Mix two different base colors.": "请混合两种不同的基础色。",
	"Pull both colors farther.": "两个颜色都要拉得更远些。",
	"Level clear. Tap to continue.": "已过关，点按继续。",
	"No shots left. Watch the board.": "出手用完，观察球局。",
	"All shots fired. Watch the collisions.": "已全部出手，观察碰撞。",
	"No %s target for missile.": "导弹没有%s色目标。",
	"No %s target path yet.": "%s色球暂时没有可打目标。",
	"%s shots match target count.": "%s色出手数已与目标数量持平。",
	"%s is already fired.": "%s色已经发射过了。",
	"One %s prediction shot only.": "%s色预测弹只能发一枚。",
	"No crystal balls.": "没有水晶球。",
	"No antimatter balls.": "没有反物质球。",
	"No missiles.": "没有导弹。",
	"No targets to freeze.": "没有可冻结的目标。",
	"Targets frozen for 5s.": "目标已冻结 5 秒。",
	"No %s targets.": "没有%s色目标。",
	"%s bomb destroyed %d.": "%s色炸弹消灭 %d 个目标。",
	"Pull a color to fire %s.": "拉任意颜色球发射%s。",
	"Need %d coins.": "需要 %d 金币。",
	"Black hole suppressed 20s.": "黑洞被压制 20 秒。",
	"Shot expired - pull again.": "弹球已耗尽，请再拉一次。",
	"AIM": "瞄准",
	"AIMER": "瞄准器",
	"Shows a golden aim guide while pulling.": "拉弓时显示金色瞄准辅助线。",
	"The guide follows your launch direction.": "辅助线沿你的出手方向延伸。",
	"One purchase = 3 pulls. Tap to equip or unequip.": "买一次可用三次；点按装备/取消装备。",
	"Aimer equipped - %d pulls left.": "瞄准器已装备，剩 %d 次。",
	"Aimer unequipped - %d pulls kept.": "已取消装备，保留 %d 次。",
	"Aim guide ready for %d pulls!": "瞄准辅助线就绪，可用 %d 次！",
	"FREEZE": "冻结",
	"Stops target balls for 5 seconds.": "让目标球停止移动 5 秒。",
	"Use it when timing or shields are tight.": "时机紧张或护盾难缠时使用。",
	"It does not remove targets by itself.": "它本身不会消灭目标。",
	"COLOR BOMB": "彩色炸弹",
	"%s BOMB": "%s色炸弹",
	"CANCEL": "取消",
	"Pick a visible color slot.": "点选一个可见的颜色卡。",
	"All targets of that color lose 1 HP.": "该颜色的所有目标扣 1 点血。",
	"Mixed-color bombs unlock on mix levels.": "混色炸弹在混色关卡解锁。",
	"Solo shots can't pop mixed targets - drag onto another color to mix!": "单色球打不掉混色目标——横向拖到另一颗色球上混色！",
	"%s bomb incoming!": "%s炸弹即将引爆！",
	"CRYSTAL BALL": "水晶球",
	"Arms the next launched ball.": "为下一颗发射的球附魔。",
	"Every target it hits loses 1 HP -": "命中任何目标都令其扣 1 点血——",
	"spiked big targets lose one spike.": "带刺大球则被敲掉一根刺。",
	"Shatters after 15 impacts (walls count,": "累计撞击 15 次后碎裂（含墙壁，",
	"the floor does not).": "不含地面）。",
	"ANTIMATTER": "反物质",
	"It destroys a black hole on contact.": "接触黑洞即可将其摧毁。",
	"Black holes cannot respawn for 20 seconds.": "黑洞 20 秒内无法重生。",
	"TRACKING MISSILE": "追踪导弹",
	"Arms the next launched color ball.": "为下一颗发射的彩色球附魔。",
	"It homes in on a same-color target.": "它会追踪同色目标。",
	"Direct hit destroys; nearby targets lose 1 HP.": "直击即摧毁；附近目标扣 1 点血。",
	"MATCH & POP": "配色爆破",
	"Start red, then yellow, then blue.": "先红，再黄，后蓝。",
	"Pull down or sideways and release.": "向下或侧向拉动后松手。",
	"Hit matching target colors to pop them.": "命中同色目标即可引爆。",
	"Clear all targets before shots run out.": "在发数耗尽前清空全部目标。",
	"REPAINT WALLS": "墙壁染色",
	"Targets can now bounce into side walls.": "目标球现在会撞上两侧墙壁。",
	"Walls repaint target balls on contact.": "墙壁会在接触时给目标球染色。",
	"Aim for the color targets have now,": "要按目标现在的颜色瞄准，",
	"not the color they started with.": "而不是它们最初的颜色。",
	"TARGET HP": "目标血量",
	"Some targets now have HP.": "部分目标现在拥有血量。",
	"They need multiple matching hits to pop.": "需要多次同色命中才能引爆。",
	"Same-color wall hits can add HP,": "同色墙壁碰撞会给目标加血，",
	"so finish charged targets quickly.": "所以要尽快解决充能的目标。",
	"BLACK HOLE": "黑洞",
	"Black holes erase player balls on contact.": "黑洞会吞噬接触到的玩家球。",
	"They shift position over time.": "它会随时间改变位置。",
	"Antimatter destroys a black hole,": "反物质可以摧毁黑洞，",
	"then blocks respawn for 20 seconds.": "并压制其重生 20 秒。",
	"MERGE TARGETS": "目标合体",
	"Same-color targets can merge together.": "同色目标可以互相合并。",
	"A merged target becomes a large ball.": "合并后的目标会变成大球。",
	"Large balls cycle shielded and vulnerable.": "大球会在护盾与破绽间循环。",
	"Shoot when the shield fades.": "在护盾消退时射击。",
	"MIX COLORS": "混色",
	"Drag one color onto another.": "把一种颜色拖到另一种颜色上。",
	"A mixed ball forms above it - pull to aim.": "混色球随即在其上方成形，拉拽瞄准。",
	"R+Y orange, Y+B green, R+B purple.": "红+黄=橙，黄+蓝=绿，红+蓝=紫。",
	"Mixed balls ignore wall repaint.": "混色球不受墙壁染色影响。",
}
const PERFECT_PRAISE_TEXTS_ZH_HANT := ["夯", "漂亮", "帥", "牛", "厲害"]
const COLOR_WORDS_ZH_HANT := {
	"red": "紅", "yellow": "黃", "blue": "藍",
	"orange": "橙", "green": "綠", "purple": "紫",
}
const SPECIAL_WORDS_ZH_HANT := {
	"crystal": "水晶球", "antimatter": "反物質", "missile": "導彈",
}
const ZH_HANT_TEXTS := {
	"CONTINUE": "繼續遊戲",
	"NEW GAME": "新遊戲",
	"SELECT LEVEL": "選擇關卡",
	"SETTING": "設定",
	"Level ": "關卡 ",
	"Coins ": "金幣 ",
	"SETTINGS": "設定",
	"VOLUME": "音量",
	"BACK": "返回",
	"OK": "確定",
	"Lv%d  T:%d  S:%d/%d  P:%d": "關%d  目標%d  發%d/%d  直%d",
	"T:": "目標",
	"S:": "出手",
	"P:": "完美",
	"FURBALL": "粉毛",
	"PINK FURBALL": "粉毛球",
	"One giant furball for your next shot.": "下一發變成一顆巨大粉毛球。",
	"It destroys ANYTHING it touches.": "它摧毀碰到的一切。",
	"Ignores shields, spikes, HP and black holes.": "無視護盾、尖刺、生命與黑洞。",
	"Its 6s fuse starts on the first target hit,": "首次撞到目標起倒數 6 秒，",
	"then it bursts into a cloud of pink smoke.": "時間一到炸成漫天粉霧。",
	"Furball armed - fire when ready!": "粉毛球已就緒——隨時發射！",
	"A furball is already on the loose!": "已有一顆粉毛球在場上撒歡！",
	"Furball armed - your next shot!": "粉毛球已就緒——就在下一發！",
	"READY": "就緒",
	"STOP": "凍結",
	"CRYSTAL": "水晶",
	"MSL": "導彈",
	"LEVEL CLEAR!": "恭喜過關！",
	"PAUSED": "已暫停",
	"Cost $%d": "花費 $%d",
	"Use it now?": "立即使用？",
	"CONFIRM": "確認",
	"%s cancelled - $%d back.": "%s已取消，返還 $%d。",
	"BASE": "基礎",
	"PERFECT": "完美",
	"SHOTS LEFT": "剩餘出手",
	"COINS": "金幣",
	"BALANCE ": "餘額 ",
	"TAP FOR NEXT": "點按進入下一關",
	"TAP TO CONTINUE": "點按繼續",
	"DEMO COMPLETE!": "試玩版通關！",
	"You've cleared the POP'EM! demo. Thank you for playing!": "您已通關彩彈爆爆試玩版，感謝支持！",
	"The full version is coming soon. Stay tuned!": "正式版近日即將上市，敬請期待。",
	"Release %s %s": "鬆手發射 %s（%s色）",
	"Release %s  |  Power %d%%": "鬆手發射 %s ｜ 力度 %d%%",
	"Release to fire  |  Power %d%%": "鬆手發射 ｜ 力度 %d%%",
	"No shots left - watch the board": "出手用完，觀察球局",
	"Pull a color to fire %s": "拉任意顏色球發射%s",
	"Black hole returns in %ds": "黑洞 %d 秒後回歸",
	"Release for single %s, or hold two colors.": "鬆手發射單個%s，或按住兩種顏色。",
	"Hold two colors to mix.": "按住兩種顏色進行混色。",
	"Release both colors together.": "兩指同時鬆開。",
	"OUT OF SHOTS": "出手用完",
	"All shots are used up.": "出手次數已經用完。",
	"Buy +%d shots for $%d": "購買 +%d 次出手（$%d）",
	"and keep popping?": "繼續闖關？",
	"Extra shots cost $%d.": "補充出手需要 $%d。",
	"Not enough coins - retry!": "金幣不足，重打本關！",
	"BUY +%d": "購買 +%d",
	"RETRY": "重試",
	"+%d shots bought.": "已購買 +%d 次出手。",
	"Pull down farther, then release.": "往下拉得更遠些再鬆手。",
	"Pull %s down/sideways": "把%s色球向下或側向拉",
	"%s first.": "先%s。",
	"Choose two different colors.": "請選擇兩種不同的顏色。",
	"Use two colors at once.": "需要同時使用兩種顏色。",
	"Mix two different base colors.": "請混合兩種不同的基礎色。",
	"Pull both colors farther.": "兩個顏色都要拉得更遠些。",
	"Level clear. Tap to continue.": "已過關，點按繼續。",
	"No shots left. Watch the board.": "出手用完，觀察球局。",
	"All shots fired. Watch the collisions.": "已全部出手，觀察碰撞。",
	"No %s target for missile.": "導彈沒有%s色目標。",
	"No %s target path yet.": "%s色球暫時沒有可打目標。",
	"%s shots match target count.": "%s色出手數已與目標數量持平。",
	"%s is already fired.": "%s色已經發射過了。",
	"One %s prediction shot only.": "%s色預測彈只能發一枚。",
	"No crystal balls.": "沒有水晶球。",
	"No antimatter balls.": "沒有反物質球。",
	"No missiles.": "沒有導彈。",
	"No targets to freeze.": "沒有可凍結的目標。",
	"Targets frozen for 5s.": "目標已凍結 5 秒。",
	"No %s targets.": "沒有%s色目標。",
	"%s bomb destroyed %d.": "%s色炸彈消滅 %d 個目標。",
	"Pull a color to fire %s.": "拉任意顏色球發射%s。",
	"Need %d coins.": "需要 %d 金幣。",
	"Black hole suppressed 20s.": "黑洞被壓制 20 秒。",
	"Shot expired - pull again.": "彈球已耗盡，請再拉一次。",
	"AIM": "瞄準",
	"AIMER": "瞄準器",
	"Shows a golden aim guide while pulling.": "拉弓時顯示金色瞄準輔助線。",
	"The guide follows your launch direction.": "輔助線沿你的出手方向延伸。",
	"One purchase = 3 pulls. Tap to equip or unequip.": "買一次可用三次；點按裝備/取消裝備。",
	"Aimer equipped - %d pulls left.": "瞄準器已裝備，剩 %d 次。",
	"Aimer unequipped - %d pulls kept.": "已取消裝備，保留 %d 次。",
	"Aim guide ready for %d pulls!": "瞄準輔助線就緒，可用 %d 次！",
	"FREEZE": "凍結",
	"Stops target balls for 5 seconds.": "讓目標球停止移動 5 秒。",
	"Use it when timing or shields are tight.": "時機緊張或護盾難纏時使用。",
	"It does not remove targets by itself.": "它本身不會消滅目標。",
	"COLOR BOMB": "彩色炸彈",
	"%s BOMB": "%s色炸彈",
	"CANCEL": "取消",
	"Pick a visible color slot.": "點選一個可見的顏色卡。",
	"All targets of that color lose 1 HP.": "該顏色的所有目標扣 1 點血。",
	"Mixed-color bombs unlock on mix levels.": "混色炸彈在混色關卡解鎖。",
	"Solo shots can't pop mixed targets - drag onto another color to mix!": "單色球打不掉混色目標——橫向拖到另一顆色球上混色！",
	"%s bomb incoming!": "%s炸彈即將引爆！",
	"CRYSTAL BALL": "水晶球",
	"Arms the next launched ball.": "為下一顆發射的球附魔。",
	"Every target it hits loses 1 HP -": "命中任何目標都令其扣 1 點血——",
	"spiked big targets lose one spike.": "帶刺大球則被敲掉一根刺。",
	"Shatters after 15 impacts (walls count,": "累計撞擊 15 次後碎裂（含牆壁，",
	"the floor does not).": "不含地面）。",
	"ANTIMATTER": "反物質",
	"It destroys a black hole on contact.": "接觸黑洞即可將其摧毀。",
	"Black holes cannot respawn for 20 seconds.": "黑洞 20 秒內無法重生。",
	"TRACKING MISSILE": "追蹤導彈",
	"Arms the next launched color ball.": "為下一顆發射的彩色球附魔。",
	"It homes in on a same-color target.": "它會追蹤同色目標。",
	"Direct hit destroys; nearby targets lose 1 HP.": "直擊即摧毀；附近目標扣 1 點血。",
	"MATCH & POP": "配色爆破",
	"Start red, then yellow, then blue.": "先紅，再黃，後藍。",
	"Pull down or sideways and release.": "向下或側向拉動後鬆手。",
	"Hit matching target colors to pop them.": "命中同色目標即可引爆。",
	"Clear all targets before shots run out.": "在發數耗盡前清空全部目標。",
	"REPAINT WALLS": "牆壁染色",
	"Targets can now bounce into side walls.": "目標球現在會撞上兩側牆壁。",
	"Walls repaint target balls on contact.": "牆壁會在接觸時給目標球染色。",
	"Aim for the color targets have now,": "要按目標現在的顏色瞄準，",
	"not the color they started with.": "而不是它們最初的顏色。",
	"TARGET HP": "目標血量",
	"Some targets now have HP.": "部分目標現在擁有血量。",
	"They need multiple matching hits to pop.": "需要多次同色命中才能引爆。",
	"Same-color wall hits can add HP,": "同色牆壁碰撞會給目標加血，",
	"so finish charged targets quickly.": "所以要儘快解決充能的目標。",
	"BLACK HOLE": "黑洞",
	"Black holes erase player balls on contact.": "黑洞會吞噬接觸到的玩家球。",
	"They shift position over time.": "它會隨時間改變位置。",
	"Antimatter destroys a black hole,": "反物質可以摧毀黑洞，",
	"then blocks respawn for 20 seconds.": "並壓制其重生 20 秒。",
	"MERGE TARGETS": "目標合體",
	"Same-color targets can merge together.": "同色目標可以互相合併。",
	"A merged target becomes a large ball.": "合併後的目標會變成大球。",
	"Large balls cycle shielded and vulnerable.": "大球會在護盾與破綻間循環。",
	"Shoot when the shield fades.": "在護盾消退時射擊。",
	"MIX COLORS": "混色",
	"Drag one color onto another.": "把一種顏色拖到另一種顏色上。",
	"A mixed ball forms above it - pull to aim.": "混色球隨即在其上方成形，拉拽瞄準。",
	"R+Y orange, Y+B green, R+B purple.": "紅+黃=橙，黃+藍=綠，紅+藍=紫。",
	"Mixed balls ignore wall repaint.": "混色球不受牆壁染色影響。",
}
const LEFT_WALL_COLORS := ["red", "yellow", "blue"]
const RIGHT_WALL_COLORS := ["blue", "yellow", "red"]
const COLOR_VALUES := {
	"red": Color("#f21b2d"),
	"yellow": Color("#ffe600"),
	"blue": Color("#12a4dc"),
	"orange": Color("#ff8a1c"),
	"green": Color("#27c65a"),
	"purple": Color("#9b45e4"),
	"crystal": Color("#f8ffff"),
	"antimatter": Color("#f4f4f4"),
}
const MENU_BACKGROUND_TEXTURE := preload("res://assets/ui/menu_background.png")
const MENU_BUTTON_TEXTURE := preload("res://assets/ui/menu_button_red.png")
const MENU_BUTTON_AMBER_TEXTURE := preload("res://assets/ui/menu_button_amber.png")
const MENU_BUTTON_BLUE_TEXTURE := preload("res://assets/ui/menu_button_blue.png")
const MENU_LOGO_TEXTURE := preload("res://assets/ui/menu_logo.png")
const MENU_LOGO_CN_TEXTURE := preload("res://assets/ui/menu_logo_cn.png")
const HUD_SHOT_ICON_TEXTURE := preload("res://assets/ui/icon_shot.png")
const MENU_PANEL_TEXTURE := preload("res://assets/ui/menu_panel.png")
const MENU_ROUND_BUTTON_TEXTURE := preload("res://assets/ui/volume_round_button.png")
const MENU_BUTTON_PURPLE_TEXTURE := preload("res://assets/ui/menu_button_purple.png")
const BLACK_HOLE_TEXTURE := preload("res://assets/ui/black_hole.png")
const MENU_BGM_STREAM := preload("res://assets/audio/menu_bgm.ogg")
const VICTORY_MUSIC_STREAM := preload("res://assets/audio/victory.ogg")
const LEVEL_COMPLETE_DELAY_SECONDS := 1.0
const VICTORY_FADE_SECONDS := 0.35
const SFX_FREEZE_STREAM := preload("res://assets/audio/sfx/sfx_freeze.ogg")
const SFX_ANTIMATTER_STREAM := preload("res://assets/audio/sfx/sfx_antimatter.ogg")
const SFX_MISSILE_FLIGHT_STREAM := preload("res://assets/audio/sfx/sfx_missile_flight.ogg")
const SFX_MISSILE_EXPLOSION_STREAM := preload("res://assets/audio/sfx/sfx_missile_explosion.ogg")
const SFX_DEMO_COMPLETE_STREAM := preload("res://assets/audio/sfx/sfx_demo_complete.mp3")
const SFX_GLASS_SHATTER_STREAM := preload("res://assets/audio/sfx/sfx_glass_shatter.ogg")
const SFX_FURBALL_POP_STREAM := preload("res://assets/audio/sfx/sfx_furball_pop.mp3")
const MEOW_LOOP_STREAM := preload("res://assets/audio/sfx/sfx_meow_loop.mp3")
const CHARGING_LOOP_STREAM := preload("res://assets/audio/sfx/sfx_charging.mp3")
const LEVEL_BGM_PLAYLIST: Array = [
	preload("res://assets/audio/level_bgm_1.ogg"),
]
const MUSIC_BASE_DB_OFFSET := -8.0
const PRAISE_VOICE_STREAMS := {
	"夯": preload("res://assets/audio/praise/zh_hang.ogg"),
	"漂亮": preload("res://assets/audio/praise/zh_piaoliang.ogg"),
	"帅": preload("res://assets/audio/praise/zh_shuai.ogg"),
	"牛": preload("res://assets/audio/praise/zh_niu.ogg"),
	"厉害": preload("res://assets/audio/praise/zh_lihai.ogg"),
	"帥": preload("res://assets/audio/praise/zh_shuai.ogg"),
	"厲害": preload("res://assets/audio/praise/zh_lihai.ogg"),
	"Bulls' Eye": preload("res://assets/audio/praise/en_bullseye.ogg"),
	"Nice Shot": preload("res://assets/audio/praise/en_niceshot.ogg"),
	"Incredible": preload("res://assets/audio/praise/en_incredible.ogg"),
	"Touchez": preload("res://assets/audio/praise/en_touchez.ogg"),
	"Perfect": preload("res://assets/audio/praise/en_perfect.ogg"),
}
const UI_PRESS_SECONDS := 0.14
const PIXEL_FONT := preload("res://assets/fonts/fusion_pixel.otf")
var pixel_font_bold := _make_pixel_font_bold()
const ARENA_BG_TEXTURE := preload("res://assets/ui/arena_bg.png")
const FRAME_CONSOLE_TEXTURE := preload("res://assets/ui/frame_console.png")
const FC_SRC_X := 40.0
const FC_SRC_W := 918.0
const FC_TOP_SRC_H := 260.0
const FC_TOP_BAND_SOLID_SRC_Y := 130.0
const FC_MID_SRC_Y := 260.0
const FC_MID_SRC_H := 890.0
const FC_BOTTOM_SRC_Y := 1150.0
const FC_BOTTOM_SRC_H := 420.0
const FC_ARENA_TOP_INNER := 162.0
const FC_ARENA_BOTTOM_INNER := 1226.0
const FC_SIDE_INNER := 81.0
const FC_SOCKET_XS := [262.0, 458.0, 653.0]
const FC_SOCKET_Y := 1435.0
const FC_CONSOLE_BODY_BOTTOM := 1540.0
const CAP_FLIP_SECONDS := 0.5
const FC_CAP_SRCS := {
	"red": Rect2(270.0, 1224.0, 66.0, 35.0),
	"yellow": Rect2(463.0, 1224.0, 72.0, 35.0),
	"blue": Rect2(657.0, 1225.0, 68.0, 34.0),
}
const PLAYER_BALL_TINT := Color(1.18, 1.14, 1.06)
const TARGET_BALL_TINT := Color(0.86, 0.87, 0.92)
const STAT_NUMBER_COLOR := Color("#44ff66")
const BADGE_TEXTURE := preload("res://assets/ui/badge_green.png")
const PLAQUE_TEXTURE := preload("res://assets/ui/plaque.png")
const PLAQUE_INFO_TEXTURE := preload("res://assets/ui/plaque_info.png")
const FURBALL_TEXTURE := preload("res://assets/ui/ball_furball.png")
const FURBALL_TEXTURE_SCALE := 1.37
const MISSILE_BALL_TEXTURE := preload("res://assets/ui/icon_rocket.png")
const FREEZE_ACTIVE_ICON_TEXTURE := preload("res://assets/ui/icon_clock_frozen.png")
const CONFIRM_BUTTON_TEXTURE := preload("res://assets/ui/button_confirm.png")
const TRINITY_TEXTURE := preload("res://assets/ui/trinity.png")
const CARD_TEXTURE := preload("res://assets/ui/card.png")
const BALL_TEXTURES := {
	"red": preload("res://assets/ui/ball_red.png"),
	"yellow": preload("res://assets/ui/ball_yellow.png"),
	"blue": preload("res://assets/ui/ball_blue.png"),
	"orange": preload("res://assets/ui/ball_orange.png"),
	"green": preload("res://assets/ui/ball_green.png"),
	"purple": preload("res://assets/ui/ball_purple.png"),
	"crystal": preload("res://assets/ui/ball_crystal.png"),
	"dark": preload("res://assets/ui/ball_dark.png"),
}
const TUBE_TEXTURES := {
	"red": preload("res://assets/ui/tube_red.png"),
	"yellow": preload("res://assets/ui/tube_yellow.png"),
	"blue": preload("res://assets/ui/tube_blue.png"),
	"orange": preload("res://assets/ui/tube_orange.png"),
	"green": preload("res://assets/ui/tube_green.png"),
	"purple": preload("res://assets/ui/tube_purple.png"),
}
const POWERUP_ICON_TEXTURES := {
	"freeze": preload("res://assets/ui/icon_clock.png"),
	"bomb": preload("res://assets/ui/icon_bomb.png"),
	"crystal": preload("res://assets/ui/icon_crystal.png"),
	"antimatter": preload("res://assets/ui/icon_antimatter.png"),
	"missile": preload("res://assets/ui/icon_rocket.png"),
	"aimer": preload("res://assets/ui/icon_aimer.png"),
}
const BOMB_ICON_TEXTURES := {
	"red": preload("res://assets/ui/icon_bomb_red.png"),
	"yellow": preload("res://assets/ui/icon_bomb_yellow.png"),
	"blue": preload("res://assets/ui/icon_bomb_blue.png"),
}
const BASE_SPEED := 255.0
const TARGET_SPEED_MULTIPLIER := 0.65
const LAUNCH_MIN_SPEED := BASE_SPEED * 1.25
const LAUNCH_MAX_SPEED := BASE_SPEED * 4.25
const COLOR_BOMB_DELAY := 0.7
const FULL_CHARGE_SPEED_BONUS := 1.2
const FULL_CHARGE_BURST_MULTIPLIER := 1.5
const FULL_CHARGE_BURST_DECAY := 4.0
const PLAYER_BALL_DRAG_PER_SECOND := 0.05
const PLAYER_BALL_BOUNCE_RESTITUTION := 0.93
const PLAYER_BALL_MIN_ALIVE_SPEED := BASE_SPEED * 0.4
const MIN_LAUNCH_PULL_RATIO := 0.18
const MAX_LAUNCH_ANGLE_DEGREES := 60.0
const MIX_DRAG_OVERLAP_DISTANCE_RATIO := 0.86
const MIX_RETARGET_TENSION_LIMIT := 0.08
const WALL_RECOLOR_COOLDOWN := 10.0
const LAUNCHER_BOTTOM_PULL_SPACE := 128.0
const LAUNCHER_CHANNEL_HEIGHT := 30.0
const MAX_PULL_RADIUS_MULTIPLIER := 2.55
const LEVEL_TARGET_COUNTS := [3, 5, 7, 9, 12, 3, 5, 7, 9, 12, 3, 5, 7, 9, 12, 4, 6, 8, 10, 12, 6, 9, 9, 12, 12, 6, 8, 10, 10, 12]
const LEVEL_SHOT_LIMITS := [4, 7, 10, 12, 16, 6, 8, 11, 14, 18, 7, 10, 14, 17, 21, 7, 10, 13, 16, 19, 12, 16, 17, 21, 23, 14, 18, 22, 24, 28]
const SHOT_LIMIT_BONUS := 5
const SAVE_PATH := "user://popem_progress.cfg"
const TARGET_RADIUS := 18.0
const BLACK_HOLE_RADIUS := TARGET_RADIUS * 3.0
const LAUNCH_RADIUS := 20.0
const MAX_LAUNCHER_COLLISIONS := 10
const MIXED_LAUNCHER_COLLISIONS := MAX_LAUNCHER_COLLISIONS * 2
const TARGET_HP_MAX := 2
const TARGET_WALL_CHARGE_MAX := 2
const COIN_BASE_REWARD := 20
const COIN_LEVEL_STEP := 5
const PERFECT_BONUS_RATE := 0.18
const PERFECT_BONUS_CAP_RATE := 1.5
const REMAINING_SHOT_BONUS_RATE := 0.08
const REMAINING_SHOT_BONUS_CAP_RATE := 0.6
const FREEZE_COST := 90
const FREEZE_DURATION := 5.0
const COLOR_BOMB_COST := 120
const CRYSTAL_BALL_COST := 400
const ANTIMATTER_BALL_COST := 140
const MISSILE_COST := 220
const AIMER_COST := 50
const AIMER_CHARGE_COUNT := 3
const PINK_FURBALL_COST := 1200
const PINK_FURBALL_LIFETIME := 6.0
const PINK_FURBALL_RADIUS_SCALE := 1.5
const EXTRA_SHOTS_PER_BUY := 3
const EXTRA_SHOT_BASE_COST := 45
const EXTRA_SHOT_LEVEL_COST := 4
const EXTRA_SHOT_REPEAT_COST := 35
const CRYSTAL_BALL_HP := 15
const CRYSTAL_BALL_RADIUS_SCALE := 1.5
const MISSILE_MIN_SPEED := BASE_SPEED * 2.6
const MISSILE_START_SPEED := MISSILE_MIN_SPEED * 0.3
const MISSILE_ACCEL := BASE_SPEED * 2.2
const MISSILE_MAX_SPEED := MISSILE_MIN_SPEED * 1.5
const MISSILE_BLAST_RADIUS := TARGET_RADIUS * 8.0
const BLACK_HOLE_LEVEL_START := 16
const BLACK_HOLE_SWALLOW_PHASE_1 := 0.18
const BLACK_HOLE_SWALLOW_SECONDS := 0.40
const BLACK_HOLE_REFRESH_SECONDS := 10.0
const BLACK_HOLE_ANTIMATTER_RESPAWN_DELAY := 20.0
const BLACK_HOLE_SPAWN_ATTEMPTS := 32
const BLACK_HOLE_SPAWN_CLEARANCE := 14.0
const BLACK_HOLE_BOTTOM_LAUNCH_CLEARANCE := 48.0
const TARGET_MERGE_LEVEL_START := 21
const TARGET_MERGE_BLACK_HOLE_LEVEL_START := 23
const COLOR_MIX_LEVEL_START := 26
const COLOR_MIX_BLACK_HOLE_LEVEL_START := 29
const MIX_RELEASE_WINDOW_SECONDS := 0.25
const MERGED_TARGET_RADIUS_MULTIPLIER := 2.0
const MERGED_TARGET_MIN_SPEED := BASE_SPEED * TARGET_SPEED_MULTIPLIER * 0.75
const MERGED_TARGET_MAX_SPEED := BASE_SPEED * TARGET_SPEED_MULTIPLIER * 1.35
const SPIKE_COUNT_MAX := 6
const SPIKE_OUT_SECONDS := 6.0
const SPIKE_COOLDOWN_SECONDS := 10.0
const SPIKE_RETRACT_SECONDS := 0.3
const POWERUP_SLOT_SIZE := 124.0
const POWERUP_SLOT_GAP := 8.0
const POWERUP_BAR_SIDE_MARGIN := 10.0
const POWERUP_SCROLL_DRAG_THRESHOLD := 9.0
const POWERUP_FLASH_SECONDS := 0.22
const POWERUP_RIPPLE_SECONDS := 0.5
const CHARGING_POWERUP_IDS := ["aimer", "crystal", "antimatter", "missile", "furball"]
const POWERUP_DUPLICATE_PRESS_WINDOW_SECONDS := 0.18
const POWERUP_DUPLICATE_PRESS_DISTANCE := 22.0
const PARTICLE_COUNT := 34
const AUDIO_MIX_RATE := 44100
const COLLISION_SOUND_DURATION := 0.074
const COLLISION_SOUND_MIN_INTERVAL := 0.045
const WALL_SOUND_MIN_INTERVAL := 0.06
const BACK_BUTTON_SIZE := 44.0
const BACK_BUTTON_MARGIN := 10.0
const TOP_BAR_SAFE_MARGIN := 74.0
const POWERUP_BAR_LAUNCHER_GAP := 10.0
const ARENA_TOP_CLEARANCE := 267.0
const WALL_TUBE_WIDTH := TARGET_RADIUS * 2.0
const WALL_FLASH_SECONDS := 0.30
const INTRO_DIALOG_WIDTH := 430.0
const TUTORIAL_PANEL_TEXTURE := preload("res://assets/ui/tutorial_panel.png")
const TUTORIAL_PANEL_ASPECT := 1420.0 / 1009.0
const TUTORIAL_INNER_X0 := 0.167
const TUTORIAL_INNER_X1 := 0.833
const TUTORIAL_INNER_Y0 := 0.173
const TUTORIAL_INNER_Y1 := 0.865
const INTRO_OK_WIDTH := 225.0
const INTRO_OK_HEIGHT := 69.0
const POWERUP_HELP_DIALOG_WIDTH := 430.0
const COMPLETE_PANEL_WIDTH := 430.0
const COMPLETE_PANEL_TEXTURE := preload("res://assets/ui/panel_info.png")
const COMPLETE_PANEL_ASPECT := 1448.0 / 1086.0
const COMPLETE_INNER_X0 := 0.245
const COMPLETE_INNER_X1 := 0.755
const COMPLETE_INNER_Y0 := 0.215
const COMPLETE_INNER_Y1 := 0.840
const COMPLETE_PERFECT_COUNT_DELAY := 0.18
const COMPLETE_PERFECT_COUNT_SECONDS := 0.70
const COMPLETE_SHOT_COUNT_DELAY := 0.42
const COMPLETE_SHOT_COUNT_SECONDS := 0.70
const COMPLETE_COIN_COUNT_DELAY := 0.72
const COMPLETE_COIN_COUNT_SECONDS := 1.25
const COIN_CHIME_DURATION := 0.055
const COIN_CHIME_MIN_INTERVAL := 0.045

var arena := Rect2(58.0, 54.0, 424.0, 748.0)
var launcher_panel := Rect2(70.0, 802.0, 400.0, 94.0)
var button_radius := 36.0
var rng := RandomNumberGenerator.new()
var balls: Array[GameBall] = []
var particles: Array[BurstParticle] = []
var floating_texts: Array[FloatingText] = []
var tutorial_step := 0
# Colors the player has launched at least once this level (level-1 tutorial).
# Unlike shots_fired it is NEVER reset by a missed shot, so the tutorial order
# only gates colors the player has not tried yet — a miss re-enables that
# color (shots_fired) without locking the colors that come after it.
var tutorial_colors_fired := {}
var shots_fired := {
	"red": false,
	"yellow": false,
	"blue": false,
}
var level_complete := false
var level_failed := false
var current_level := 1
var shots_used := 0
var shot_limit := 0
var extra_shot_purchases := 0
var invalid_prompt_timer := 0.0
var invalid_prompt_text := ""
var prompt_at_launcher := false
var drag_active := false
var active_touch_index := -1
var drag_color := ""
var drag_position := Vector2.ZERO
var drag_raw_position := Vector2.ZERO
var drag_mix_locked := false
var drag_mix_first_color := ""
var drag_mix_result_color := ""
var mix_touch_drags := {}
var next_mix_batch_id := 1
var coin_count := 0
var freeze_stock := 0
var color_bomb_stock := {
	"red": 0,
	"yellow": 0,
	"blue": 0,
	"orange": 0,
	"green": 0,
	"purple": 0,
}
var crystal_stock := 0
var antimatter_stock := 0
var missile_stock := 0
var armed_special_kind := ""
var target_freeze_timer := 0.0
var level_perfect_hits := 0
var last_level_reward := 0
var last_level_base_reward := 0
var last_level_perfect_bonus := 0
var last_level_remaining_shots := 0
var last_level_shot_bonus := 0
var last_level_coin_start := 0
var level_complete_anim_time := 0.0
var level_complete_last_coin_chime_time := -999.0
var level_complete_last_displayed_coin_reward := 0
var level_complete_panel_rect := Rect2()
var powerup_slots := {}
var powerup_bar_rect := Rect2()
var powerup_scroll_offset := 0.0
var powerup_scroll_max := 0.0
var powerup_touch_active := false
var powerup_touch_start_position := Vector2.ZERO
var powerup_touch_last_position := Vector2.ZERO
var powerup_touch_start_offset := 0.0
var powerup_touch_candidate_id := ""
var powerup_touch_dragging := false
var powerup_touch_blocked := false
var powerup_flash_id := ""
var powerup_flash_timer := 0.0
var powerup_ripple := {}
var furball_shot_armed := false
var last_powerup_press_id := ""
var last_powerup_press_time := -999.0
var last_powerup_press_position := Vector2.ZERO
var menu_active := true
var start_menu_buttons := {}
var settings_active := false
var level_select_active := false
var level_select_buttons := {}
var highest_level := 1
var pending_color_bombs := []
var menu_anim_time := 0.0
var effects_anim_time := 0.0
var wall_tube_inset := 0.0
var wall_flash_timers := {}
var cap_flip_timers := {}
var cap_openness := {}
var powerup_press_zoom := {}
var cap_mouth_style: StyleBoxFlat = null
var powerup_tag_style: StyleBoxFlat = null
var fc_scale := 1.0
var fc_top_rect := Rect2()
var fc_mid_rect := Rect2()
var fc_bottom_rect := Rect2()
var ui_press_flash := {}
var glow_gradient_texture: GradientTexture2D = null
var settings_buttons := {}
var settings_panel_rect := Rect2()
var settings_language := "en"
var settings_volume := 1.0
var black_hole_enabled := false
var black_hole_active := false
var black_hole_position := Vector2.ZERO
var black_hole_timer := 0.0
var black_hole_respawn_cooldown := 0.0
var collision_sound_timer := 0.0
var wall_sound_timer := 0.0
var back_button_rect := Rect2()
var hud_label: Label
var coin_label: Label
var prompt_label: Label
var level_intro_active := false
var level_intro_title := ""
var level_intro_lines := []
var level_intro_dialog_rect := Rect2()
var level_failed_dialog_rect := Rect2()
var level_failed_ok_rect := Rect2()
var powerup_confirm_active := false
var powerup_confirm_id := ""
var powerup_confirm_dialog_rect := Rect2()
var powerup_confirm_ok_rect := Rect2()
var back_menu_delay_timer := 0.0
var game_paused := false
var pause_button_rect := Rect2()
var level_intro_ok_rect := Rect2()
var trial_end_active := false
var trial_end_dialog_rect := Rect2()
var trial_end_ok_rect := Rect2()
var powerup_help_active := false
var powerup_help_id := ""
var powerup_help_title := ""
var powerup_help_lines := []
var powerup_help_pending_id := ""
var powerup_help_seen := {
	"freeze": false,
	"bomb": false,
	"crystal": false,
	"antimatter": false,
	"missile": false,
	"aimer": false,
}
var aimer_armed := false
var aimer_charges := 0
var powerup_help_dialog_rect := Rect2()
var powerup_help_ok_rect := Rect2()
var powerup_help_cancel_rect := Rect2()
var audio_player: AudioStreamPlayer
var collision_audio_player: AudioStreamPlayer
var music_player: AudioStreamPlayer
var current_bgm: AudioStream = null
var voice_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer
var freeze_sfx_player: AudioStreamPlayer
var meow_player: AudioStreamPlayer
var charging_player: AudioStreamPlayer
var missile_flight_player: AudioStreamPlayer
var victory_player: AudioStreamPlayer
var victory_fade_timer := 0.0
var level_complete_pending := false
var level_complete_delay_timer := 0.0

class GameBall:
	var position: Vector2
	var velocity: Vector2
	var speed: float
	var radius: float
	var color_name: String
	var is_target: bool
	var collision_count := 0
	var hp := 1
	var max_hp := 1
	var wall_charge_count := 0
	var wall_recolor_cooldown := 0.0
	var special_kind := ""
	var special_hp := 1
	var merged_target := false
	var spike_state := ""
	var spike_timer := 0.0
	var spike_count := 0
	var is_furball := false
	var furball_life := -1.0
	var burst_settle_speed := -1.0
	var mix_batch_id := 0
	var mix_result_color := ""
	var mix_result_special_kind := ""
	var spin_angle := 0.0
	var spin_velocity := 0.0
	var swallow_timer := -1.0
	var swallow_base_radius := 0.0

	func _init(ball_position: Vector2, ball_velocity: Vector2, ball_speed: float, ball_radius: float, ball_color_name: String, target: bool) -> void:
		position = ball_position
		velocity = ball_velocity
		speed = ball_speed
		radius = ball_radius
		color_name = ball_color_name
		is_target = target

class FloatingText:
	var label: Label
	var velocity: Vector2
	var life := 0.85
	var max_life := 0.85
	var popup := false

	func _init(text_label: Label, text_velocity: Vector2, popup_text := false, text_life := 0.85) -> void:
		label = text_label
		velocity = text_velocity
		popup = popup_text
		life = text_life
		max_life = text_life

class BurstParticle:
	var position: Vector2
	var velocity: Vector2
	var color: Color
	var radius: float
	var kind := "puff"
	var life := 0.42
	var max_life := 0.42

	func _init(particle_position: Vector2, particle_velocity: Vector2, particle_color: Color, particle_radius: float, particle_kind := "puff", particle_life := 0.42) -> void:
		position = particle_position
		velocity = particle_velocity
		color = particle_color
		radius = particle_radius
		kind = particle_kind
		life = particle_life
		max_life = particle_life

func _ready() -> void:
	rng.randomize()
	_setup_audio()
	_setup_labels()
	_load_progress()
	_update_layout()
	_show_start_menu()
	set_process(true)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_SIZE_CHANGED:
		_update_layout()
		queue_redraw()

func _input(event: InputEvent) -> void:
	# Handle the physical event once, without its mouse/touch emulation copy.
	if event.device == InputEvent.DEVICE_ID_EMULATION:
		return
	# Only the finger that began a launcher or power-up gesture may finish it.
	if event is InputEventScreenTouch:
		if event.pressed:
			if active_touch_index != -1 and event.index != active_touch_index:
				return
		else:
			if event.index != active_touch_index:
				return
			active_touch_index = -1
	elif event is InputEventScreenDrag and event.index != active_touch_index:
		return

	# A canceled system gesture is not a release to fire or buy a power-up.
	if event is InputEventScreenTouch and event.canceled:
		_clear_drag()
		queue_redraw()
		return

	if menu_active:
		if _is_primary_press(event):
			var menu_press_position := _primary_press_position(event)
			if settings_active:
				_handle_settings_press(menu_press_position)
			elif level_select_active:
				_handle_level_select_press(menu_press_position)
			else:
				_handle_start_menu_press(menu_press_position)
		return

	if powerup_confirm_active:
		if _is_primary_press(event):
			_handle_powerup_confirm_press(_primary_press_position(event))
		return

	if powerup_help_active:
		if _is_primary_press(event):
			_handle_powerup_help_press(_primary_press_position(event))
		return

	if _is_primary_press(event) and _handle_back_button_press(_primary_press_position(event)):
		return

	if level_intro_active:
		if _is_primary_press(event):
			_handle_level_intro_press(_primary_press_position(event))
		return

	if level_failed:
		if _is_primary_press(event):
			var press_position := _primary_press_position(event)
			if level_failed_ok_rect.size.x <= 0.0:
				_layout_level_failed_dialog()
			if level_failed_ok_rect.has_point(press_position):
				_register_ui_press("failed_ok")
				_handle_failed_level_press()
		return

	if trial_end_active:
		if _is_primary_press(event):
			_handle_trial_end_press(_primary_press_position(event))
		return

	if level_complete:
		if _is_primary_press(event):
			_play_ui_click_sound()
			if current_level >= LEVEL_TARGET_COUNTS.size():
				_show_trial_end_dialog()
			else:
				_start_next_level()
		return

	if _is_primary_press(event) and pause_button_rect.size.x > 0.0 and pause_button_rect.has_point(_primary_press_position(event)):
		_register_ui_press("pause")
		game_paused = not game_paused
		if game_paused:
			_clear_drag()
		queue_redraw()
		return

	if game_paused:
		return

	if _handle_powerup_input(event):
		if event is InputEventScreenTouch and event.pressed:
			active_touch_index = event.index
		return

	if event is InputEventScreenTouch:
		if event.pressed:
			_begin_drag(event.position)
			if drag_active:
				active_touch_index = event.index
		else:
			_release_drag(event.position)
	elif event is InputEventScreenDrag:
		_update_drag(event.position)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_begin_drag(event.position)
		else:
			_release_drag(event.position)
	elif event is InputEventMouseMotion and drag_active and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_update_drag(event.position)
	elif event is InputEventKey and event.pressed and not event.echo:
		var selected_color := _keyboard_color(event)
		if selected_color != "":
			_launch_color(selected_color, 0.55)

func _can_use_mix_touch_input() -> bool:
	return _level_has_color_mixing() and (armed_special_kind == "" or _is_mixed_launch_special(armed_special_kind))

func _is_mixed_launch_special(special_kind: String) -> bool:
	return special_kind == "missile" or special_kind == "crystal" or special_kind == "antimatter"

func _is_primary_press(event: InputEvent) -> bool:
	if event.device == InputEvent.DEVICE_ID_EMULATION:
		return false
	return (event is InputEventScreenTouch and event.pressed) or (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT)

func _primary_press_position(event: InputEvent) -> Vector2:
	if event is InputEventScreenTouch:
		return event.position
	if event is InputEventMouseButton:
		return event.position
	return Vector2.ZERO

func _handle_powerup_input(event: InputEvent) -> bool:
	if event is InputEventScreenTouch:
		if event.pressed:
			return _begin_powerup_touch(event.position)
		return _release_powerup_touch(event.position)
	if event is InputEventScreenDrag:
		return _update_powerup_touch(event.position)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			return _begin_powerup_touch(event.position)
		return _release_powerup_touch(event.position)
	if event is InputEventMouseMotion and powerup_touch_active and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return _update_powerup_touch(event.position)
	return false

func _begin_powerup_touch(position: Vector2) -> bool:
	if not _powerup_bar_contains_position(position):
		return false
	powerup_touch_active = true
	powerup_touch_start_position = position
	powerup_touch_last_position = position
	powerup_touch_start_offset = powerup_scroll_offset
	powerup_touch_candidate_id = ""
	powerup_touch_dragging = false
	powerup_touch_blocked = false
	powerup_touch_blocked = _is_powerup_input_locked()
	if powerup_touch_blocked:
		return true
	powerup_touch_start_position = position
	powerup_touch_last_position = position
	powerup_touch_start_offset = powerup_scroll_offset
	powerup_touch_candidate_id = _powerup_at(position)
	powerup_touch_dragging = false
	if powerup_touch_candidate_id != "":
		_play_powerup_press_sound()
		queue_redraw()
	return true

func _update_powerup_touch(position: Vector2) -> bool:
	if not powerup_touch_active:
		return false
	if powerup_touch_blocked:
		return true
	var total_delta := position - powerup_touch_start_position
	var threshold := _powerup_scroll_drag_threshold()
	if not powerup_touch_dragging and absf(total_delta.x) >= threshold and absf(total_delta.x) > absf(total_delta.y):
		powerup_touch_dragging = true
	if powerup_touch_dragging:
		powerup_scroll_offset = clampf(powerup_touch_start_offset - total_delta.x, 0.0, powerup_scroll_max)
		_layout_powerup_slots()
		queue_redraw()
	powerup_touch_last_position = position
	return true

func _release_powerup_touch(position: Vector2) -> bool:
	if not powerup_touch_active:
		return false
	var was_blocked := powerup_touch_blocked
	var was_dragging := powerup_touch_dragging
	var candidate_id := powerup_touch_candidate_id
	var moved := position.distance_to(powerup_touch_start_position)
	_clear_powerup_touch()
	if was_blocked:
		return true
	if not was_dragging and moved <= _powerup_scroll_drag_threshold():
		var released_id := _powerup_at(position)
		if released_id != "" and released_id == candidate_id:
			_handle_powerup_tap(released_id, position)
	return true

func _clear_powerup_touch() -> void:
	powerup_touch_active = false
	powerup_touch_start_position = Vector2.ZERO
	powerup_touch_last_position = Vector2.ZERO
	powerup_touch_start_offset = 0.0
	powerup_touch_candidate_id = ""
	powerup_touch_dragging = false
	powerup_touch_blocked = false

func _powerup_scroll_drag_threshold() -> float:
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	return POWERUP_SCROLL_DRAG_THRESHOLD * scale

func _powerup_bar_contains_position(position: Vector2) -> bool:
	if powerup_bar_rect.size.x <= 0.0 or powerup_bar_rect.size.y <= 0.0:
		_layout_powerup_slots()
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	return powerup_bar_rect.grow(8.0 * scale).has_point(position)

func _handle_back_button_press(position: Vector2) -> bool:
	if back_button_rect.size.x <= 0.0 or not back_button_rect.has_point(position):
		return false
	if back_menu_delay_timer > 0.0:
		return true
	_register_ui_press("back")
	back_menu_delay_timer = 0.13
	return true

func _return_to_start_menu() -> void:
	_clear_drag()
	if level_complete:
		current_level = current_level + 1 if current_level < LEVEL_TARGET_COUNTS.size() else 1
	_save_progress(current_level)
	_show_start_menu()
	queue_redraw()

var jank_prev_frame_usec: int = -1
var jank_draw_usec: int = 0
var jank_process_usec: int = 0

func _process(delta: float) -> void:
	var frame_usec := Time.get_ticks_usec()
	if jank_prev_frame_usec >= 0 and not menu_active and OS.is_debug_build():
		var gap_ms := float(frame_usec - jank_prev_frame_usec) / 1000.0
		if gap_ms > 150.0:
			print("JANK gap=%.0fms proc=%.1fms draw=%.1fms level=%d shots=%d balls=%d particles=%d texts=%d" % [gap_ms, float(jank_process_usec) / 1000.0, float(jank_draw_usec) / 1000.0, current_level, shots_used, balls.size(), particles.size(), floating_texts.size()])
	jank_prev_frame_usec = frame_usec
	_step_ui_press_flash(delta)
	if back_menu_delay_timer > 0.0:
		back_menu_delay_timer = maxf(back_menu_delay_timer - delta, 0.0)
		if back_menu_delay_timer <= 0.0 and not menu_active:
			_return_to_start_menu()
	if menu_active:
		menu_anim_time += delta
		_update_start_menu_labels()
		queue_redraw()
		return
	effects_anim_time += delta
	if victory_fade_timer > 0.0:
		victory_fade_timer = maxf(victory_fade_timer - delta, 0.0)
		if victory_player != null:
			if victory_fade_timer <= 0.0:
				victory_player.stop()
			else:
				victory_player.volume_db = _settings_base_db() + MUSIC_BASE_DB_OFFSET + linear_to_db(victory_fade_timer / VICTORY_FADE_SECONDS)
	if level_complete_pending:
		level_complete_delay_timer = maxf(level_complete_delay_timer - delta, 0.0)
		if level_complete_delay_timer <= 0.0:
			_finalize_level_complete()
	if invalid_prompt_timer > 0.0:
		invalid_prompt_timer -= delta
	if powerup_flash_timer > 0.0:
		powerup_flash_timer = maxf(powerup_flash_timer - delta, 0.0)
	for ripple_key in powerup_ripple.keys():
		var ripple_remaining: float = float(powerup_ripple[ripple_key]) - delta
		if ripple_remaining <= 0.0:
			powerup_ripple.erase(ripple_key)
		else:
			powerup_ripple[ripple_key] = ripple_remaining
	if collision_sound_timer > 0.0:
		collision_sound_timer = maxf(collision_sound_timer - delta, 0.0)
	if wall_sound_timer > 0.0:
		wall_sound_timer = maxf(wall_sound_timer - delta, 0.0)
	if level_complete:
		_step_particles(delta)
		_step_floating_texts(delta)
		_step_level_complete_panel(delta)
		_update_prompt()
		queue_redraw()
		return
	if powerup_help_active:
		_update_prompt()
		queue_redraw()
		return
	if powerup_confirm_active:
		_update_prompt()
		queue_redraw()
		return
	if level_intro_active:
		_update_prompt()
		queue_redraw()
		return
	if level_failed:
		_step_particles(delta)
		_step_floating_texts(delta)
		_update_prompt()
		queue_redraw()
		return
	if game_paused:
		if meow_player != null:
			meow_player.stream_paused = true
		if charging_player != null and charging_player.playing:
			charging_player.stop()
		_update_prompt()
		queue_redraw()
		return
	if meow_player != null and meow_player.stream_paused:
		meow_player.stream_paused = false
	if target_freeze_timer > 0.0:
		target_freeze_timer = maxf(target_freeze_timer - delta, 0.0)
	_step_furball_lifetimes(delta)
	_step_pending_bombs(delta)
	_update_charging_audio()
	_expire_pending_mix_releases()
	_step_black_hole(delta)
	_step_balls(delta)
	_step_particles(delta)
	_step_floating_texts(delta)
	_update_prompt()
	queue_redraw()

func _draw() -> void:
	var draw_start_usec := Time.get_ticks_usec()
	if jank_prev_frame_usec >= 0:
		jank_process_usec = draw_start_usec - jank_prev_frame_usec
	if menu_active:
		_draw_start_menu()
		return
	_draw_menu_background(get_viewport_rect().size)
	_draw_back_button()
	_draw_arena()
	_draw_disco_lights()
	_draw_top_hud()
	_draw_black_hole()
	_draw_balls()
	_draw_missile_locks()
	_draw_particles()
	_draw_launcher()
	_draw_powerup_bar()
	_draw_launcher_bands()
	_draw_prompt_tag()
	_draw_pause_overlay()
	_draw_pause_button()
	_draw_level_complete_panel()
	_draw_trial_end_dialog()
	_draw_level_intro_dialog()
	_draw_powerup_help_dialog()
	_draw_powerup_confirm_dialog()
	_draw_level_failed_dialog()
	jank_draw_usec = Time.get_ticks_usec() - draw_start_usec

func _setup_labels() -> void:
	hud_label = Label.new()
	hud_label.add_theme_font_override("font", PIXEL_FONT)
	hud_label.add_theme_font_size_override("font_size", 22)
	hud_label.add_theme_color_override("font_color", Color("#111111"))
	hud_label.position = Vector2(22.0, 12.0)
	add_child(hud_label)

	coin_label = Label.new()
	coin_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	coin_label.add_theme_font_override("font", PIXEL_FONT)
	coin_label.add_theme_font_size_override("font_size", 22)
	coin_label.add_theme_color_override("font_color", Color("#111111"))
	coin_label.position = Vector2(340.0, 12.0)
	coin_label.size = Vector2(178.0, 28.0)
	add_child(coin_label)

	prompt_label = Label.new()
	prompt_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	prompt_label.add_theme_font_override("font", PIXEL_FONT)
	prompt_label.add_theme_font_size_override("font_size", 22)
	prompt_label.add_theme_color_override("font_color", Color("#111111"))
	prompt_label.position = Vector2(12.0, 908.0)
	prompt_label.size = Vector2(516.0, 40.0)
	prompt_label.visible = false
	add_child(prompt_label)

func _setup_audio() -> void:
	audio_player = AudioStreamPlayer.new()
	var stream := AudioStreamGenerator.new()
	stream.mix_rate = AUDIO_MIX_RATE
	stream.buffer_length = 0.28
	audio_player.stream = stream
	add_child(audio_player)
	audio_player.play()

	collision_audio_player = AudioStreamPlayer.new()
	var collision_stream := AudioStreamGenerator.new()
	collision_stream.mix_rate = AUDIO_MIX_RATE
	collision_stream.buffer_length = 0.12
	collision_audio_player.stream = collision_stream
	collision_audio_player.volume_db = -9.0
	add_child(collision_audio_player)
	collision_audio_player.play()

	music_player = AudioStreamPlayer.new()
	add_child(music_player)

	voice_player = AudioStreamPlayer.new()
	add_child(voice_player)

	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	freeze_sfx_player = AudioStreamPlayer.new()
	freeze_sfx_player.stream = SFX_FREEZE_STREAM
	add_child(freeze_sfx_player)
	meow_player = AudioStreamPlayer.new()
	var meow_stream: AudioStreamMP3 = MEOW_LOOP_STREAM
	meow_stream.loop = true
	meow_player.stream = meow_stream
	add_child(meow_player)
	charging_player = AudioStreamPlayer.new()
	var charging_stream: AudioStreamMP3 = CHARGING_LOOP_STREAM
	charging_stream.loop = true
	charging_player.stream = charging_stream
	add_child(charging_player)
	missile_flight_player = AudioStreamPlayer.new()
	missile_flight_player.stream = SFX_MISSILE_FLIGHT_STREAM
	add_child(missile_flight_player)
	victory_player = AudioStreamPlayer.new()
	victory_player.stream = VICTORY_MUSIC_STREAM
	add_child(victory_player)

	var loop_streams: Array = [MENU_BGM_STREAM, SFX_MISSILE_FLIGHT_STREAM]
	loop_streams.append_array(LEVEL_BGM_PLAYLIST)
	for bgm_stream in loop_streams:
		bgm_stream.loop = true

func _level_bgm_stream(level: int) -> AudioStream:
	if LEVEL_BGM_PLAYLIST.is_empty():
		return null
	return LEVEL_BGM_PLAYLIST[(level - 1) % LEVEL_BGM_PLAYLIST.size()]

func _play_bgm(stream: AudioStream) -> void:
	if music_player == null or stream == null:
		return
	if stream == current_bgm and music_player.playing:
		return
	current_bgm = stream
	music_player.stream = stream
	music_player.play()

func _update_layout() -> void:
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var arena_width = viewport_size.x
	var panel_height = 94.0 * scale
	var powerup_bottom_space := _powerup_bar_reserved_bottom_space(scale)
	var panel_y = viewport_size.y - panel_height - maxf(LAUNCHER_BOTTOM_PULL_SPACE * scale, powerup_bottom_space)
	fc_scale = viewport_size.x / FC_SRC_W
	var fc_bottom_y: float = (panel_y + panel_height) - (FC_CONSOLE_BODY_BOTTOM - FC_BOTTOM_SRC_Y) * fc_scale
	fc_bottom_rect = Rect2(Vector2(0.0, fc_bottom_y), Vector2(viewport_size.x, FC_BOTTOM_SRC_H * fc_scale))
	var fc_top_y: float = ARENA_TOP_CLEARANCE * scale
	fc_top_rect = Rect2(Vector2(0.0, fc_top_y), Vector2(viewport_size.x, FC_TOP_SRC_H * fc_scale))
	fc_mid_rect = Rect2(Vector2(0.0, fc_top_rect.end.y), Vector2(viewport_size.x, maxf(fc_bottom_y - fc_top_rect.end.y, 0.0)))
	var arena_y = fc_top_y + FC_ARENA_TOP_INNER * fc_scale
	var arena_height = maxf(320.0 * scale, fc_bottom_y + (FC_ARENA_BOTTOM_INNER - FC_BOTTOM_SRC_Y) * fc_scale - arena_y)
	wall_tube_inset = FC_SIDE_INNER * fc_scale + WALL_TUBE_WIDTH
	arena = Rect2(
		Vector2(0.0, arena_y),
		Vector2(arena_width, arena_height)
	)
	launcher_panel = Rect2(
		Vector2((viewport_size.x - 400.0 * scale) * 0.5, panel_y),
		Vector2(400.0 * scale, panel_height)
	)
	button_radius = 36.0 * scale
	var pause_size: float = 60.0 * scale
	var plaque_bottom_y: float = (176.0 + 99.0) * scale
	var frame_band_top_y: float = fc_top_rect.position.y + FC_TOP_BAND_SOLID_SRC_Y * fc_scale
	var pause_center_y: float = (plaque_bottom_y + frame_band_top_y) * 0.5
	pause_button_rect = Rect2(Vector2((viewport_size.x - pause_size) * 0.5, pause_center_y - pause_size * 0.5), Vector2(pause_size, pause_size))
	_layout_back_button()
	if hud_label != null:
		hud_label.position = Vector2(64.0 * scale, TOP_BAR_SAFE_MARGIN * scale)
		hud_label.add_theme_font_size_override("font_size", int(18.0 * scale))
		hud_label.size = Vector2(maxf(220.0 * scale, viewport_size.x - 244.0 * scale), 30.0 * scale)
	if coin_label != null:
		coin_label.position = Vector2(viewport_size.x - 178.0 * scale, TOP_BAR_SAFE_MARGIN * scale)
		coin_label.size = Vector2(160.0 * scale, 30.0 * scale)
	_layout_powerup_slots()
	_layout_start_menu_buttons()
	_layout_settings_menu()
	_layout_level_intro_dialog()
	_layout_trial_end_dialog()
	_layout_powerup_help_dialog()
	_layout_powerup_confirm_dialog()
	_layout_level_failed_dialog()
	_layout_level_complete_panel()
	_position_prompt_label(level_complete)
	if drag_active:
		drag_position = _drag_preview_position(drag_position)
	_refresh_mix_drag_layout()

func _layout_back_button() -> void:
	var scale: float = minf(get_viewport_rect().size.x / 540.0, get_viewport_rect().size.y / 960.0)
	var badge_center_y: float = (44.0 + 63.0) * scale
	var button_height: float = 46.0 * scale
	var button_width: float = 160.0 * scale
	back_button_rect = Rect2(Vector2(12.0 * scale, badge_center_y - button_height * 0.5), Vector2(button_width, button_height))

func _layout_powerup_slots() -> void:
	var viewport_size := get_viewport_rect().size
	var scale: float = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var slot_size: float = POWERUP_SLOT_SIZE * scale
	var gap: float = POWERUP_SLOT_GAP * scale
	var margin: float = POWERUP_BAR_SIDE_MARGIN * scale
	var slot_ids: Array = _visible_powerup_slot_ids()
	var y: float = minf(launcher_panel.position.y + launcher_panel.size.y + POWERUP_BAR_LAUNCHER_GAP * scale, viewport_size.y - _powerup_bar_height(1, scale) - 8.0 * scale)
	var bar_width: float = minf(maxf(0.0, viewport_size.x - margin * 2.0), 520.0 * scale)
	powerup_bar_rect = Rect2(Vector2((viewport_size.x - bar_width) * 0.5, y), Vector2(bar_width, slot_size))
	var content_width := _powerup_bar_content_width(slot_ids.size(), scale)
	powerup_scroll_max = maxf(content_width - powerup_bar_rect.size.x, 0.0)
	powerup_scroll_offset = clampf(powerup_scroll_offset, 0.0, powerup_scroll_max)
	var start_x := powerup_bar_rect.position.x - powerup_scroll_offset
	if content_width < powerup_bar_rect.size.x:
		start_x = powerup_bar_rect.position.x + (powerup_bar_rect.size.x - content_width) * 0.5
	powerup_slots = {}
	for index in range(slot_ids.size()):
		var slot_id := String(slot_ids[index])
		var x := start_x + (slot_size + gap) * float(index)
		powerup_slots[slot_id] = Rect2(Vector2(x, y), Vector2(slot_size, slot_size))

func _visible_powerup_slot_ids() -> Array:
	var slot_ids := ["aimer", "freeze"]
	for color_name in _visible_color_bomb_order():
		slot_ids.append("bomb_%s" % color_name)
	slot_ids.append("crystal")
	slot_ids.append("antimatter")
	slot_ids.append("missile")
	slot_ids.append("furball")
	return slot_ids

func _powerup_bar_content_width(total_slots: int, scale: float) -> float:
	if total_slots <= 0:
		return 0.0
	return POWERUP_SLOT_SIZE * scale * float(total_slots) + POWERUP_SLOT_GAP * scale * float(total_slots - 1)

func _powerup_bar_columns(total_slots: int) -> int:
	return total_slots

func _powerup_bar_rows() -> int:
	return 1

func _powerup_bar_height(_rows: int, scale: float) -> float:
	return POWERUP_SLOT_SIZE * scale

func _powerup_bar_reserved_bottom_space(scale: float) -> float:
	return POWERUP_BAR_LAUNCHER_GAP * scale + _powerup_bar_height(1, scale) + 8.0 * scale

func _visible_color_bomb_order() -> Array:
	return POWERUP_BOMB_COLOR_ORDER.duplicate()

func _layout_start_menu_buttons() -> void:
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var button_size = Vector2(300.0 * scale, 100.0 * scale)
	var x = (viewport_size.x - button_size.x) * 0.5
	var y = viewport_size.y * 0.56
	start_menu_buttons = {
		"continue": Rect2(Vector2(x, y), button_size),
		"restart": Rect2(Vector2(x, y + 118.0 * scale), button_size),
		"settings": Rect2(Vector2(x, y + 236.0 * scale), button_size),
	}

func _layout_level_select() -> void:
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	level_select_buttons = {}
	var cols := 5
	var chip: float = 74.0 * scale
	var gap: float = 12.0 * scale
	var grid_width: float = cols * chip + (cols - 1) * gap
	var origin_x: float = (viewport_size.x - grid_width) * 0.5
	var origin_y: float = viewport_size.y * 0.20
	for index in range(LEVEL_TARGET_COUNTS.size()):
		var col := index % cols
		var row := int(floor(float(index) / float(cols)))
		level_select_buttons["level_%d" % (index + 1)] = Rect2(
			Vector2(origin_x + col * (chip + gap), origin_y + row * (chip + gap)),
			Vector2(chip, chip))
	var rows := int(ceilf(float(LEVEL_TARGET_COUNTS.size()) / float(cols)))
	var back_size := Vector2(250.0 * scale, 82.0 * scale)
	level_select_buttons["back"] = Rect2(
		Vector2((viewport_size.x - back_size.x) * 0.5, origin_y + rows * (chip + gap) + 22.0 * scale),
		back_size)

func _handle_level_select_press(position: Vector2) -> void:
	if level_select_buttons.is_empty():
		_layout_level_select()
	var back_rect: Rect2 = level_select_buttons.get("back", Rect2())
	if back_rect.has_point(position):
		_register_ui_press("level_select_back")
		level_select_active = false
		queue_redraw()
		return
	for index in range(LEVEL_TARGET_COUNTS.size()):
		var level := index + 1
		var rect: Rect2 = level_select_buttons.get("level_%d" % level, Rect2())
		if rect.has_point(position):
			if level > highest_level:
				return
			_register_ui_press("level_pick_%d" % level)
			level_select_active = false
			menu_active = false
			settings_active = false
			current_level = level
			_save_progress(current_level)
			_start_level()
			return

func _layout_settings_menu() -> void:
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var panel_texture_size := Vector2(MENU_PANEL_TEXTURE.get_size())
	var panel_width: float = 430.0 * scale
	var panel_height: float = panel_width * panel_texture_size.y / maxf(panel_texture_size.x, 1.0)
	var panel_size := Vector2(panel_width, panel_height)
	var panel_position := Vector2((viewport_size.x - panel_size.x) * 0.5, (viewport_size.y - panel_size.y) * 0.45)
	settings_panel_rect = Rect2(panel_position, panel_size)
	var capsule_size := Vector2(260.0 * scale, 58.0 * scale)
	var capsule_x: float = panel_position.x + (panel_size.x - capsule_size.x) * 0.5
	var round_size := Vector2(62.0 * scale, 62.0 * scale)
	var lang_top: float = panel_position.y + 114.0 * scale
	var lang_step: float = 68.0 * scale
	var volume_row_y: float = panel_position.y + 352.0 * scale
	var back_size := Vector2(260.0 * scale, 66.0 * scale)
	settings_buttons = {
		"lang_en": Rect2(Vector2(capsule_x, lang_top), capsule_size),
		"lang_zh": Rect2(Vector2(capsule_x, lang_top + lang_step), capsule_size),
		"lang_zh_hant": Rect2(Vector2(capsule_x, lang_top + lang_step * 2.0), capsule_size),
		"volume_down": Rect2(Vector2(panel_position.x + 90.0 * scale, volume_row_y), round_size),
		"volume_up": Rect2(Vector2(panel_position.x + panel_size.x - 90.0 * scale - round_size.x, volume_row_y), round_size),
		"back": Rect2(Vector2(panel_position.x + (panel_size.x - back_size.x) * 0.5, panel_position.y + 422.0 * scale), back_size),
	}

func _show_start_menu() -> void:
	menu_active = true
	settings_active = false
	level_select_active = false
	level_complete = false
	level_failed = false
	game_paused = false
	_clear_powerup_confirm()
	balls.clear()
	particles.clear()
	_clear_floating_texts()
	_clear_drag()
	black_hole_active = false
	black_hole_enabled = false
	armed_special_kind = ""
	aimer_armed = aimer_charges > 0
	if meow_player != null and meow_player.playing:
		meow_player.stop()
	_clear_level_intro()
	_clear_trial_end_dialog()
	_clear_powerup_help()
	_clear_level_complete_panel()
	_layout_start_menu_buttons()
	_layout_settings_menu()
	_update_start_menu_labels()
	_play_bgm(MENU_BGM_STREAM)

func _update_start_menu_labels() -> void:
	if hud_label != null:
		hud_label.text = ""
	if coin_label != null:
		coin_label.text = ""
	if prompt_label != null:
		prompt_label.text = ""

func _handle_start_menu_press(position: Vector2) -> void:
	if start_menu_buttons.is_empty():
		_layout_start_menu_buttons()
	var continue_rect: Rect2 = start_menu_buttons.get("continue", Rect2())
	var restart_rect: Rect2 = start_menu_buttons.get("restart", Rect2())
	var settings_rect: Rect2 = start_menu_buttons.get("settings", Rect2())
	if continue_rect.has_point(position):
		_register_ui_press("menu_continue")
		level_select_active = true
		_layout_level_select()
		queue_redraw()
	elif restart_rect.has_point(position):
		_register_ui_press("menu_restart")
		current_level = 1
		_save_progress(current_level)
		menu_active = false
		settings_active = false
		_start_level()
	elif settings_rect.has_point(position):
		_register_ui_press("menu_settings")
		settings_active = true
		_layout_settings_menu()
		queue_redraw()

func _handle_settings_press(position: Vector2) -> void:
	if settings_buttons.is_empty():
		_layout_settings_menu()
	var volume_down_rect: Rect2 = settings_buttons.get("volume_down", Rect2())
	var volume_up_rect: Rect2 = settings_buttons.get("volume_up", Rect2())
	var back_rect: Rect2 = settings_buttons.get("back", Rect2())
	var lang_pressed := ""
	for lang in ["en", "zh", "zh_hant"]:
		if Rect2(settings_buttons.get("lang_%s" % lang, Rect2())).has_point(position):
			lang_pressed = lang
			break
	if lang_pressed != "":
		_register_ui_press("settings_lang_%s" % lang_pressed)
		settings_language = lang_pressed
		_save_progress(current_level)
		queue_redraw()
	elif volume_down_rect.has_point(position):
		_register_ui_press("settings_volume_down")
		settings_volume = clampf(settings_volume - 0.25, 0.0, 1.0)
		_apply_audio_settings()
		_save_progress(current_level)
		queue_redraw()
	elif volume_up_rect.has_point(position):
		_register_ui_press("settings_volume_up")
		settings_volume = clampf(settings_volume + 0.25, 0.0, 1.0)
		_apply_audio_settings()
		_save_progress(current_level)
		queue_redraw()
	elif back_rect.has_point(position):
		_register_ui_press("settings_back")
		settings_active = false
		queue_redraw()

func _handle_level_intro_press(position: Vector2) -> void:
	if level_intro_ok_rect.size.x <= 0.0:
		_layout_level_intro_dialog()
	if level_intro_ok_rect.has_point(position):
		_register_ui_press("intro_ok")
		_clear_level_intro()
		_update_prompt()
		queue_redraw()

func _clear_level_intro() -> void:
	level_intro_active = false
	level_intro_title = ""
	level_intro_lines.clear()
	level_intro_dialog_rect = Rect2()
	level_intro_ok_rect = Rect2()

func _show_trial_end_dialog() -> void:
	trial_end_active = true
	_clear_drag()
	_layout_trial_end_dialog()
	_play_sfx(SFX_DEMO_COMPLETE_STREAM)

func _handle_trial_end_press(position: Vector2) -> void:
	if trial_end_ok_rect.size.x <= 0.0:
		_layout_trial_end_dialog()
	if trial_end_ok_rect.has_point(position):
		_register_ui_press("trial_end_ok")
		_clear_trial_end_dialog()
		current_level = 1
		_save_progress(current_level)
		_show_start_menu()

func _clear_trial_end_dialog() -> void:
	trial_end_active = false
	trial_end_dialog_rect = Rect2()
	trial_end_ok_rect = Rect2()

func _handle_powerup_help_press(position: Vector2) -> void:
	if powerup_help_ok_rect.size.x <= 0.0:
		_layout_powerup_help_dialog()
	if powerup_help_ok_rect.has_point(position):
		_register_ui_press("help_ok")
		var pending_id := powerup_help_pending_id
		if powerup_help_id != "":
			powerup_help_seen[powerup_help_id] = true
		_save_progress(current_level)
		_clear_powerup_help()
		if pending_id != "" and not menu_active and not level_complete and not level_failed:
			_activate_powerup_by_id(pending_id)
		_update_prompt()
		queue_redraw()
		return
	# CANCEL button or a tap outside: the intro was read (mark it seen) but
	# nothing gets bought/activated.
	if powerup_help_cancel_rect.has_point(position):
		_register_ui_press("help_cancel")
	else:
		_play_ui_click_sound()
	if powerup_help_id != "":
		powerup_help_seen[powerup_help_id] = true
	_save_progress(current_level)
	_clear_powerup_help()
	_update_prompt()
	queue_redraw()

func _clear_powerup_help() -> void:
	powerup_help_active = false
	powerup_help_id = ""
	powerup_help_title = ""
	powerup_help_lines.clear()
	powerup_help_pending_id = ""
	powerup_help_dialog_rect = Rect2()
	powerup_help_ok_rect = Rect2()
	powerup_help_cancel_rect = Rect2()

func _powerup_help_for_id(help_id: String) -> Dictionary:
	match help_id:
		"aimer":
			return {
				"title": "AIMER",
				"lines": [
					"Shows a golden aim guide while pulling.",
					"The guide follows your launch direction.",
					"One purchase = 3 pulls. Tap to equip or unequip.",
				],
			}
		"freeze":
			return {
				"title": "FREEZE",
				"lines": [
					"Stops target balls for 5 seconds.",
					"Use it when timing or shields are tight.",
					"It does not remove targets by itself.",
				],
			}
		"bomb":
			return {
				"title": "COLOR BOMB",
				"lines": [
					"Pick a visible color slot.",
					"All targets of that color lose 1 HP.",
					"Mixed-color bombs unlock on mix levels.",
				],
			}
		"crystal":
			return {
				"title": "CRYSTAL BALL",
				"lines": [
					"Arms the next launched ball.",
					"Every target it hits loses 1 HP -",
					"spiked big targets lose one spike.",
					"Shatters after 15 impacts (walls count,",
					"the floor does not).",
				],
			}
		"antimatter":
			return {
				"title": "ANTIMATTER",
				"lines": [
					"Arms the next launched ball.",
					"It destroys a black hole on contact.",
					"Black holes cannot respawn for 20 seconds.",
				],
			}
		"missile":
			return {
				"title": "TRACKING MISSILE",
				"lines": [
					"Arms the next launched color ball.",
					"It homes in on a same-color target.",
					"Direct hit destroys; nearby targets lose 1 HP.",
				],
			}
		"furball":
			return {
				"title": "PINK FURBALL",
				"lines": [
					"One giant furball for your next shot.",
					"It destroys ANYTHING it touches.",
					"Ignores shields, spikes, HP and black holes.",
					"Its 6s fuse starts on the first target hit,",
					"then it bursts into a cloud of pink smoke.",
				],
			}
	return {}

func _show_powerup_help(help_id: String, pending_id: String) -> void:
	var help := _powerup_help_for_id(help_id)
	if help.is_empty():
		return
	powerup_help_active = true
	powerup_help_id = help_id
	powerup_help_title = _t(String(help.get("title", "")))
	powerup_help_lines = []
	for line in help.get("lines", []):
		powerup_help_lines.append(_t(String(line)))
	powerup_help_pending_id = pending_id
	_clear_drag()
	_layout_powerup_help_dialog()

func _powerup_help_id_for_powerup(powerup_id: String) -> String:
	if powerup_id.begins_with("bomb_"):
		return "bomb"
	return powerup_id

func _level_intro_for_level(level: int) -> Dictionary:
	match level:
		1:
			return {
				"title": "MATCH & POP",
				"lines": [
					"Start red, then yellow, then blue.",
					"Pull down or sideways and release.",
					"Hit matching target colors to pop them.",
					"Clear all targets before shots run out.",
				],
			}
		6:
			return {
				"title": "REPAINT WALLS",
				"lines": [
					"Targets can now bounce into side walls.",
					"Walls repaint target balls on contact.",
					"Aim for the color targets have now,",
					"not the color they started with.",
				],
			}
		11:
			return {
				"title": "TARGET HP",
				"lines": [
					"Some targets now have HP.",
					"They need multiple matching hits to pop.",
					"Same-color wall hits can add HP,",
					"so finish charged targets quickly.",
				],
			}
		16:
			return {
				"title": "BLACK HOLE",
				"lines": [
					"Black holes erase player balls on contact.",
					"They shift position over time.",
					"Antimatter destroys a black hole,",
					"then blocks respawn for 20 seconds.",
				],
			}
		21:
			return {
				"title": "MERGE TARGETS",
				"lines": [
					"Same-color targets can merge together.",
					"A merged target becomes a large ball.",
					"Large balls cycle shielded and vulnerable.",
					"Shoot when the shield fades.",
				],
			}
		26:
			return {
				"title": "MIX COLORS",
				"lines": [
					"Drag one color onto another.",
					"A mixed ball forms above it - pull to aim.",
					"R+Y orange, Y+B green, R+B purple.",
					"Mixed balls ignore wall repaint.",
				],
			}
	return {}

func _start_level_intro_if_needed() -> void:
	var intro := _level_intro_for_level(current_level)
	if intro.is_empty():
		_clear_level_intro()
		return
	level_intro_active = true
	level_intro_title = _t(String(intro.get("title", "")))
	level_intro_lines = []
	for line in intro.get("lines", []):
		level_intro_lines.append(_t(String(line)))
	_clear_drag()
	_layout_level_intro_dialog()

func _clear_level_complete_panel() -> void:
	level_complete_anim_time = 0.0
	level_complete_last_coin_chime_time = -999.0
	level_complete_last_displayed_coin_reward = 0
	level_complete_panel_rect = Rect2()

func _start_level_complete_panel() -> void:
	_clear_level_complete_panel()
	_layout_level_complete_panel()

func _layout_level_complete_panel() -> void:
	if not level_complete:
		level_complete_panel_rect = Rect2()
		return
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var margin = 22.0 * scale
	var panel_width = minf(COMPLETE_PANEL_WIDTH * scale, viewport_size.x - margin * 2.0)
	var panel_height = panel_width * COMPLETE_PANEL_ASPECT
	if panel_height > viewport_size.y - margin * 2.0:
		panel_height = viewport_size.y - margin * 2.0
		panel_width = panel_height / COMPLETE_PANEL_ASPECT
	var panel_position = Vector2((viewport_size.x - panel_width) * 0.5, (viewport_size.y - panel_height) * 0.5)
	level_complete_panel_rect = Rect2(panel_position, Vector2(panel_width, panel_height))

func _layout_level_intro_dialog() -> void:
	if not level_intro_active:
		level_intro_dialog_rect = Rect2()
		level_intro_ok_rect = Rect2()
		return
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var margin = 24.0 * scale
	var dialog_width = minf(INTRO_DIALOG_WIDTH * scale, viewport_size.x - margin * 2.0)
	var dialog_height = dialog_width * TUTORIAL_PANEL_ASPECT
	if dialog_height > viewport_size.y - margin * 2.0:
		dialog_height = viewport_size.y - margin * 2.0
		dialog_width = dialog_height / TUTORIAL_PANEL_ASPECT
	var dialog_position = Vector2((viewport_size.x - dialog_width) * 0.5, (viewport_size.y - dialog_height) * 0.5)
	level_intro_dialog_rect = Rect2(dialog_position, Vector2(dialog_width, dialog_height))
	var ok_size := Vector2(INTRO_OK_WIDTH * scale, INTRO_OK_HEIGHT * scale)
	level_intro_ok_rect = Rect2(
		Vector2(dialog_position.x + (dialog_width - ok_size.x) * 0.5, dialog_position.y + dialog_height * TUTORIAL_INNER_Y1 - ok_size.y - 10.0 * scale),
		ok_size
	)

func _layout_trial_end_dialog() -> void:
	if not trial_end_active:
		trial_end_dialog_rect = Rect2()
		trial_end_ok_rect = Rect2()
		return
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var margin = 24.0 * scale
	var dialog_width = minf(COMPLETE_PANEL_WIDTH * scale, viewport_size.x - margin * 2.0)
	var dialog_height = dialog_width * COMPLETE_PANEL_ASPECT
	if dialog_height > viewport_size.y - margin * 2.0:
		dialog_height = viewport_size.y - margin * 2.0
		dialog_width = dialog_height / COMPLETE_PANEL_ASPECT
	var dialog_position = Vector2((viewport_size.x - dialog_width) * 0.5, (viewport_size.y - dialog_height) * 0.5)
	trial_end_dialog_rect = Rect2(dialog_position, Vector2(dialog_width, dialog_height))
	var ok_size := Vector2(INTRO_OK_WIDTH * scale, INTRO_OK_HEIGHT * scale)
	trial_end_ok_rect = Rect2(
		Vector2(dialog_position.x + (dialog_width - ok_size.x) * 0.5, dialog_position.y + dialog_height * COMPLETE_INNER_Y1 - ok_size.y - 10.0 * scale),
		ok_size
	)

func _layout_powerup_help_dialog() -> void:
	if not powerup_help_active:
		powerup_help_dialog_rect = Rect2()
		powerup_help_ok_rect = Rect2()
		powerup_help_cancel_rect = Rect2()
		return
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var margin = 24.0 * scale
	var dialog_width = minf(POWERUP_HELP_DIALOG_WIDTH * scale, viewport_size.x - margin * 2.0)
	var dialog_height = dialog_width * TUTORIAL_PANEL_ASPECT
	if dialog_height > viewport_size.y - margin * 2.0:
		dialog_height = viewport_size.y - margin * 2.0
		dialog_width = dialog_height / TUTORIAL_PANEL_ASPECT
	var dialog_position = Vector2((viewport_size.x - dialog_width) * 0.5, (viewport_size.y - dialog_height) * 0.5)
	powerup_help_dialog_rect = Rect2(dialog_position, Vector2(dialog_width, dialog_height))
	# OK + CANCEL side by side so the intro never forces a purchase.
	var button_gap: float = 16.0 * scale
	var button_width: float = minf(INTRO_OK_WIDTH * scale, (dialog_width * 0.86 - button_gap) * 0.5)
	var ok_size := Vector2(button_width, INTRO_OK_HEIGHT * scale)
	var buttons_left: float = dialog_position.x + (dialog_width - ok_size.x * 2.0 - button_gap) * 0.5
	var buttons_y: float = dialog_position.y + dialog_height * TUTORIAL_INNER_Y1 - ok_size.y - 10.0 * scale
	powerup_help_ok_rect = Rect2(Vector2(buttons_left, buttons_y), ok_size)
	powerup_help_cancel_rect = Rect2(Vector2(buttons_left + ok_size.x + button_gap, buttons_y), ok_size)

func _layout_level_failed_dialog() -> void:
	if not level_failed:
		level_failed_dialog_rect = Rect2()
		level_failed_ok_rect = Rect2()
		return
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var margin = 24.0 * scale
	var dialog_width = minf(INTRO_DIALOG_WIDTH * scale, viewport_size.x - margin * 2.0)
	var dialog_height = dialog_width * TUTORIAL_PANEL_ASPECT
	if dialog_height > viewport_size.y - margin * 2.0:
		dialog_height = viewport_size.y - margin * 2.0
		dialog_width = dialog_height / TUTORIAL_PANEL_ASPECT
	var dialog_position = Vector2((viewport_size.x - dialog_width) * 0.5, (viewport_size.y - dialog_height) * 0.5)
	level_failed_dialog_rect = Rect2(dialog_position, Vector2(dialog_width, dialog_height))
	var ok_size := Vector2(INTRO_OK_WIDTH * scale, INTRO_OK_HEIGHT * scale)
	level_failed_ok_rect = Rect2(
		Vector2(dialog_position.x + (dialog_width - ok_size.x) * 0.5, dialog_position.y + dialog_height * TUTORIAL_INNER_Y1 - ok_size.y - 10.0 * scale),
		ok_size
	)

func _layout_powerup_confirm_dialog() -> void:
	if not powerup_confirm_active:
		powerup_confirm_dialog_rect = Rect2()
		powerup_confirm_ok_rect = Rect2()
		return
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var margin = 24.0 * scale
	var dialog_width = minf(360.0 * scale, viewport_size.x - margin * 2.0)
	var dialog_height = dialog_width * TUTORIAL_PANEL_ASPECT
	if dialog_height > viewport_size.y - margin * 2.0:
		dialog_height = viewport_size.y - margin * 2.0
		dialog_width = dialog_height / TUTORIAL_PANEL_ASPECT
	var dialog_position = Vector2((viewport_size.x - dialog_width) * 0.5, (viewport_size.y - dialog_height) * 0.5)
	powerup_confirm_dialog_rect = Rect2(dialog_position, Vector2(dialog_width, dialog_height))
	var ok_size := Vector2(INTRO_OK_WIDTH * scale, INTRO_OK_HEIGHT * scale)
	powerup_confirm_ok_rect = Rect2(
		Vector2(dialog_position.x + (dialog_width - ok_size.x) * 0.5, dialog_position.y + dialog_height * TUTORIAL_INNER_Y1 - ok_size.y - 10.0 * scale),
		ok_size
	)

func _position_prompt_label(centered: bool) -> void:
	if prompt_label == null:
		return
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	if centered:
		prompt_label.add_theme_font_size_override("font_size", 34)
		prompt_label.position = Vector2(arena.position.x, arena.position.y + arena.size.y * 0.48 - 28.0 * scale)
		prompt_label.size = Vector2(arena.size.x, 64.0 * scale)
	else:
		prompt_label.add_theme_font_size_override("font_size", 22)
		prompt_label.position = Vector2(arena.position.x + 12.0 * scale, arena.position.y + arena.size.y - 52.0 * scale)
		prompt_label.size = Vector2(arena.size.x - 24.0 * scale, 40.0 * scale)

func _start_level() -> void:
	menu_active = false
	current_level = clampi(current_level, 1, LEVEL_TARGET_COUNTS.size())
	_save_progress(current_level)
	_play_bgm(_level_bgm_stream(current_level))
	_update_layout()
	balls.clear()
	particles.clear()
	_clear_floating_texts()
	drag_active = false
	drag_color = ""
	active_touch_index = -1
	tutorial_step = 0
	level_complete = false
	level_complete_pending = false
	level_complete_delay_timer = 0.0
	if victory_player != null and victory_player.playing:
		victory_fade_timer = VICTORY_FADE_SECONDS
	level_failed = false
	game_paused = false
	_clear_powerup_confirm()
	_clear_trial_end_dialog()
	shots_used = 0
	shot_limit = _base_shot_limit_for_level(current_level)
	extra_shot_purchases = 0
	armed_special_kind = ""
	powerup_scroll_offset = 0.0
	_clear_powerup_touch()
	target_freeze_timer = 0.0
	pending_color_bombs.clear()
	if freeze_sfx_player != null and freeze_sfx_player.playing:
		freeze_sfx_player.stop()
	if missile_flight_player != null and missile_flight_player.playing:
		missile_flight_player.stop()
	if meow_player != null and meow_player.playing:
		meow_player.stop()
	black_hole_enabled = _level_has_black_holes()
	black_hole_active = false
	black_hole_timer = 0.0
	black_hole_respawn_cooldown = 0.0
	level_perfect_hits = 0
	last_level_reward = 0
	last_level_base_reward = 0
	last_level_perfect_bonus = 0
	last_level_remaining_shots = 0
	last_level_shot_bonus = 0
	last_level_coin_start = coin_count
	_clear_level_complete_panel()
	invalid_prompt_timer = 0.0
	for color_name in shots_fired.keys():
		shots_fired[color_name] = false
	tutorial_colors_fired.clear()
	_spawn_level_targets()
	if black_hole_enabled:
		_spawn_black_hole()
	_start_level_intro_if_needed()
	_clear_powerup_help()
	_update_prompt()
	_warm_up_effects()

# First-hit effects (particles, outlined praise glyphs, praise voice) trigger
# lazy engine-side initialization that caused a visible stall on the first
# shot. Run them once, nearly invisible and silent, while the level intro
# still covers the board.
var effects_warmed := false

func _warm_up_effects() -> void:
	if effects_warmed or DisplayServer.get_name() == "headless":
		return
	effects_warmed = true
	var warm_position := Vector2(arena.position.x + arena.size.x * 0.5, arena.position.y + arena.size.y * 0.5)
	particles.append(BurstParticle.new(warm_position, Vector2.ZERO, Color(1.0, 0.82, 0.90, 0.02), 5.0, "puff", 0.25))
	particles.append(BurstParticle.new(warm_position, Vector2.ZERO, Color(1.0, 0.85, 0.55, 0.02), 3.0, "spark", 0.25))
	particles.append(BurstParticle.new(warm_position, Vector2.ZERO, Color(1.0, 1.0, 1.0, 0.02), 8.0, "flash", 0.20))
	var warm_texts: Array[String] = []
	for praise_list in [PERFECT_PRAISE_TEXTS, PERFECT_PRAISE_TEXTS_ZH, PERFECT_PRAISE_TEXTS_ZH_HANT]:
		for praise in praise_list:
			warm_texts.append(String(praise))
	var label := Label.new()
	label.text = " ".join(warm_texts) + " +1-BOOMIX"
	label.add_theme_font_override("font", PIXEL_FONT)
	label.add_theme_font_size_override("font_size", 46)
	label.add_theme_constant_override("outline_size", 7)
	label.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 0.02))
	label.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 0.02))
	label.position = Vector2(8.0, -6.0)
	add_child(label)
	floating_texts.append(FloatingText.new(label, Vector2.ZERO, false, 0.2))
	if voice_player != null:
		var saved_voice_db := voice_player.volume_db
		voice_player.volume_db = -80.0
		voice_player.stream = PRAISE_VOICE_STREAMS["漂亮"]
		voice_player.play()
		voice_player.stop()
		voice_player.volume_db = saved_voice_db
	if sfx_player != null:
		var saved_sfx_db := sfx_player.volume_db
		sfx_player.volume_db = -80.0
		sfx_player.stream = SFX_GLASS_SHATTER_STREAM
		sfx_player.play()
		sfx_player.stop()
		sfx_player.volume_db = saved_sfx_db

func _start_next_level() -> void:
	if current_level < LEVEL_TARGET_COUNTS.size():
		current_level += 1
	else:
		current_level = 1
	_save_progress(current_level)
	_start_level()

func _load_progress() -> void:
	var config := ConfigFile.new()
	var error := config.load(SAVE_PATH)
	if error != OK:
		current_level = 1
		_apply_audio_settings()
		return
	var saved_level = int(config.get_value("progress", "current_level", 1))
	current_level = clampi(saved_level, 1, LEVEL_TARGET_COUNTS.size())
	highest_level = clampi(int(config.get_value("progress", "highest_level", current_level)), 1, LEVEL_TARGET_COUNTS.size())
	highest_level = maxi(highest_level, current_level)
	coin_count = maxi(int(config.get_value("progress", "coins", 0)), 0)
	aimer_charges = clampi(int(config.get_value("powerups", "aimer_charges", 0)), 0, AIMER_CHARGE_COUNT)
	aimer_armed = aimer_charges > 0
	furball_shot_armed = int(config.get_value("powerups", "furball_shot", 0)) > 0
	settings_language = String(config.get_value("settings", "language", "en"))
	if settings_language != "en" and settings_language != "zh" and settings_language != "zh_hant":
		settings_language = "en"
	settings_volume = clampf(float(config.get_value("settings", "volume", 1.0)), 0.0, 1.0)
	_apply_audio_settings()
	freeze_stock = 0
	crystal_stock = 0
	antimatter_stock = 0
	missile_stock = 0
	for help_id in powerup_help_seen.keys():
		powerup_help_seen[help_id] = bool(config.get_value("powerup_help", String(help_id), false))
	for color_name in POWERUP_BOMB_COLOR_ORDER:
		color_bomb_stock[color_name] = 0

func _settings_base_db() -> float:
	var clamped_volume := clampf(settings_volume, 0.0, 1.0)
	return -80.0 if clamped_volume <= 0.0 else linear_to_db(clamped_volume)

func _apply_audio_settings() -> void:
	var base_db := _settings_base_db()
	if audio_player != null:
		audio_player.volume_db = base_db
	if collision_audio_player != null:
		collision_audio_player.volume_db = base_db - 9.0
	if music_player != null:
		music_player.volume_db = base_db + MUSIC_BASE_DB_OFFSET
	if voice_player != null:
		voice_player.volume_db = base_db
	if sfx_player != null:
		sfx_player.volume_db = base_db
	if freeze_sfx_player != null:
		freeze_sfx_player.volume_db = base_db - 3.0
	if missile_flight_player != null:
		missile_flight_player.volume_db = base_db - 6.0
	if meow_player != null:
		meow_player.volume_db = base_db
	if charging_player != null:
		charging_player.volume_db = base_db - 2.0
	if victory_player != null and victory_fade_timer <= 0.0:
		victory_player.volume_db = base_db + MUSIC_BASE_DB_OFFSET

func _settings_volume_percent() -> int:
	return int(round(clampf(settings_volume, 0.0, 1.0) * 100.0))

func _save_progress(level: int) -> void:
	var config := ConfigFile.new()
	highest_level = maxi(highest_level, clampi(level, 1, LEVEL_TARGET_COUNTS.size()))
	config.set_value("progress", "current_level", clampi(level, 1, LEVEL_TARGET_COUNTS.size()))
	config.set_value("progress", "highest_level", highest_level)
	config.set_value("progress", "coins", maxi(coin_count, 0))
	config.set_value("settings", "language", settings_language)
	config.set_value("settings", "volume", clampf(settings_volume, 0.0, 1.0))
	config.set_value("powerups", "aimer_charges", maxi(aimer_charges, 0))
	config.set_value("powerups", "furball_shot", 1 if furball_shot_armed else 0)
	config.set_value("powerups", "freeze", 0)
	config.set_value("powerups", "crystal", 0)
	config.set_value("powerups", "antimatter", 0)
	config.set_value("powerups", "missile", 0)
	for help_id in powerup_help_seen.keys():
		config.set_value("powerup_help", String(help_id), bool(powerup_help_seen[help_id]))
	for color_name in POWERUP_BOMB_COLOR_ORDER:
		config.set_value("powerups", "bomb_%s" % color_name, 0)
	config.save(SAVE_PATH)

func _spawn_level_targets() -> void:
	var target_count: int = LEVEL_TARGET_COUNTS[current_level - 1]
	if current_level == 1:
		_spawn_tutorial_targets()
		return
	if _level_has_color_mixing():
		_spawn_color_mix_targets(target_count)
		return

	var columns = 3 if target_count <= 9 else 4
	var rows = ceili(float(target_count) / float(columns))
	var x_margin = arena.size.x * 0.16
	var top_y = arena.position.y + arena.size.y * 0.12
	var vertical_span = arena.size.y * 0.48

	for index in range(target_count):
		var color_name: String = COLOR_ORDER[index % COLOR_ORDER.size()]
		var col = index % columns
		var row = int(float(index) / float(columns))
		var x_fraction = (float(col) + 0.5) / float(columns)
		var y_fraction = (float(row) + 0.5) / float(rows)
		var position = Vector2(
			arena.position.x + x_margin + (arena.size.x - x_margin * 2.0) * x_fraction + rng.randf_range(-12.0, 12.0),
			top_y + vertical_span * y_fraction + rng.randf_range(-10.0, 10.0)
		)
		_spawn_target_ball(color_name, position, index)

func _spawn_color_mix_targets(target_count: int) -> void:
	var sequence := _color_mix_target_sequence_for_level(current_level)
	if sequence.is_empty():
		sequence = MIXED_COLOR_ORDER
	var columns = 3 if target_count <= 9 else 4
	var rows = ceili(float(target_count) / float(columns))
	var x_margin = arena.size.x * 0.16
	var top_y = arena.position.y + arena.size.y * 0.11
	var vertical_span = arena.size.y * 0.50

	for index in range(target_count):
		var color_name: String = sequence[index % sequence.size()]
		var col = index % columns
		var row = int(float(index) / float(columns))
		var x_fraction = (float(col) + 0.5) / float(columns)
		var y_fraction = (float(row) + 0.5) / float(rows)
		var position = Vector2(
			arena.position.x + x_margin + (arena.size.x - x_margin * 2.0) * x_fraction + rng.randf_range(-10.0, 10.0),
			top_y + vertical_span * y_fraction + rng.randf_range(-8.0, 8.0)
		)
		_spawn_target_ball(color_name, position, index)

func _color_mix_target_sequence_for_level(level: int) -> Array:
	match level:
		26:
			return ["orange", "green", "purple", "orange", "green", "purple"]
		27:
			return ["orange", "green", "purple", "orange", "green", "purple", "orange", "green"]
		28:
			return ["orange", "orange", "green", "green", "purple", "purple", "orange", "green", "purple", "orange"]
		29:
			return ["orange", "green", "purple", "orange", "green", "purple", "orange", "green", "purple", "orange"]
		30:
			return ["orange", "orange", "green", "green", "purple", "purple", "orange", "green", "purple", "orange", "green", "purple"]
	return MIXED_COLOR_ORDER

func _spawn_tutorial_targets() -> void:
	var spawn_positions := [
		Vector2(arena.position.x + arena.size.x * 0.22, arena.position.y + arena.size.y * 0.30),
		Vector2(arena.position.x + arena.size.x * 0.50, arena.position.y + arena.size.y * 0.45),
		Vector2(arena.position.x + arena.size.x * 0.76, arena.position.y + arena.size.y * 0.18),
	]

	for index in range(COLOR_ORDER.size()):
		var color_name: String = COLOR_ORDER[index]
		_spawn_target_ball(color_name, spawn_positions[index], index)

func _spawn_target_ball(color_name: String, position: Vector2, target_index := 0) -> void:
	var speed = BASE_SPEED * TARGET_SPEED_MULTIPLIER * float(rng.randi_range(1, 3))
	var angle = deg_to_rad(rng.randf_range(0.0, 45.0))
	var side := -1.0 if rng.randi_range(0, 1) == 0 else 1.0
	var velocity = Vector2(sin(angle) * side, cos(angle)).normalized() * speed
	var target_ball := GameBall.new(position, velocity, speed, TARGET_RADIUS, color_name, true)
	target_ball.max_hp = TARGET_HP_MAX if _level_has_target_hp() else 1
	target_ball.hp = _initial_target_hp(target_index)
	balls.append(target_ball)

func _initial_target_hp(target_index: int) -> int:
	if not _level_has_target_hp():
		return 1
	if current_level >= BLACK_HOLE_LEVEL_START:
		return 1
	if current_level <= 12:
		return 1
	if current_level == 13:
		return 2 if target_index % 4 == 0 else 1
	if current_level == 14:
		return 2 if target_index % 3 == 0 else 1
	return 2 if target_index % 2 == 0 else 1

func _begin_drag(position: Vector2) -> void:
	var selected_color := _button_color_at(position)
	if selected_color == "":
		return
	if not _can_begin_color_drag(selected_color):
		return

	drag_active = true
	drag_color = selected_color
	drag_raw_position = position
	drag_position = _drag_preview_position(position)
	_refresh_drag_mix_target()

func _can_begin_color_drag(color_name: String) -> bool:
	if _level_has_color_mixing() and _is_primary_color(color_name):
		return true
	return _validate_launch_color(color_name)

func _update_drag(position: Vector2) -> void:
	if not drag_active:
		return
	drag_raw_position = position
	drag_position = _drag_preview_position(position)
	_refresh_drag_mix_target()

func _release_drag(position: Vector2) -> void:
	if not drag_active:
		return
	drag_raw_position = position
	drag_position = _drag_preview_position(position)
	_refresh_drag_mix_target()
	var color_name := drag_color
	var mix_locked := drag_mix_locked
	var mixed_color := drag_mix_result_color
	var tension := _launch_tension()
	var launch_direction := _launch_direction()
	_clear_drag()

	if tension < MIN_LAUNCH_PULL_RATIO:
		_pulse_prompt(_weak_launch_prompt())
		return

	if mix_locked:
		_launch_drag_mixed_color(color_name, mixed_color, tension, launch_direction)
		return

	if armed_special_kind != "":
		_launch_armed_special(color_name, tension, launch_direction)
	else:
		_launch_color(color_name, tension, launch_direction)

func _clear_drag() -> void:
	active_touch_index = -1
	if charging_player != null and charging_player.playing:
		charging_player.stop()
	drag_active = false
	drag_color = ""
	drag_position = Vector2.ZERO
	drag_raw_position = Vector2.ZERO
	drag_mix_locked = false
	drag_mix_first_color = ""
	drag_mix_result_color = ""
	mix_touch_drags.clear()
	_clear_powerup_touch()

func _drag_gesture_is_horizontal() -> bool:
	var anchor_color := drag_mix_first_color if drag_mix_locked else drag_color
	if anchor_color == "":
		return false
	var displacement := drag_raw_position - _button_center(anchor_color)
	return absf(displacement.x) >= absf(displacement.y)

func _refresh_drag_mix_target() -> void:
	if drag_mix_locked:
		if _launch_tension() >= MIX_RETARGET_TENSION_LIMIT:
			return
		var retarget_color := _drag_mix_target_at(drag_raw_position)
		if retarget_color == "":
			return
		var retarget_mixed := _mixed_color_for_pair(drag_mix_first_color, retarget_color)
		if retarget_mixed == "":
			return
		drag_color = retarget_color
		drag_mix_result_color = retarget_mixed
		drag_position = _drag_preview_position(drag_raw_position)
		return
	if not _drag_gesture_is_horizontal():
		return
	var target_color := _drag_mix_target_at(drag_raw_position)
	if target_color == "":
		return
	var mixed_color := _mixed_color_for_pair(drag_color, target_color)
	if mixed_color == "":
		return
	drag_mix_locked = true
	drag_mix_first_color = drag_color
	drag_mix_result_color = mixed_color
	drag_color = target_color
	drag_position = _drag_preview_position(drag_raw_position)

func _drag_mix_target_at(position: Vector2) -> String:
	if not drag_active or not _level_has_color_mixing() or drag_color == "":
		return ""
	for color_name in COLOR_ORDER:
		if color_name == drag_color:
			continue
		if position.distance_to(_button_center(color_name)) <= button_radius * MIX_DRAG_OVERLAP_DISTANCE_RATIO:
			return color_name
	return ""

func _handle_mix_screen_touch(event: InputEventScreenTouch) -> void:
	if event.pressed:
		_begin_mix_touch(event.index, event.position)
	else:
		_release_mix_touch(event.index, event.position)

func _handle_mix_screen_drag(event: InputEventScreenDrag) -> void:
	if not mix_touch_drags.has(event.index):
		return
	var entry: Dictionary = mix_touch_drags[event.index]
	if bool(entry.get("released", false)):
		return
	var color_name := String(entry.get("color", ""))
	entry["position"] = _drag_preview_position_for_color(event.position, color_name)
	mix_touch_drags[event.index] = entry

func _begin_mix_touch(touch_index: int, position: Vector2) -> void:
	var selected_color := _button_color_at(position)
	if selected_color == "":
		return
	if _mix_active_color_count(selected_color) > 0:
		_pulse_prompt(_t("Choose two different colors."))
		return
	if mix_touch_drags.size() >= 2 and not mix_touch_drags.has(touch_index):
		_pulse_prompt(_t("Use two colors at once."))
		return
	mix_touch_drags[touch_index] = {
		"color": selected_color,
		"position": _drag_preview_position_for_color(position, selected_color),
		"released": false,
		"release_time": 0.0,
	}

func _release_mix_touch(touch_index: int, position: Vector2) -> void:
	if not mix_touch_drags.has(touch_index):
		return
	var entry: Dictionary = mix_touch_drags[touch_index]
	var color_name := String(entry.get("color", ""))
	entry["position"] = _drag_preview_position_for_color(position, color_name)
	entry["released"] = true
	entry["release_time"] = _now_seconds()
	mix_touch_drags[touch_index] = entry
	if _is_mixed_launch_special(armed_special_kind) and mix_touch_drags.size() == 1:
		_launch_single_special_from_mix_touch(entry)
		return
	_try_launch_mix_pair()

func _launch_single_special_from_mix_touch(entry: Dictionary) -> void:
	var color_name := String(entry.get("color", ""))
	var position: Vector2 = entry.get("position", Vector2.ZERO)
	var tension := _launch_tension_for_color(color_name, position)
	var launch_direction := _launch_direction_for_color(color_name, position)
	mix_touch_drags.clear()
	if tension < MIN_LAUNCH_PULL_RATIO:
		_pulse_prompt(_weak_launch_prompt())
		return
	_launch_armed_special(color_name, tension, launch_direction)

func _try_launch_mix_pair() -> void:
	if mix_touch_drags.size() < 2:
		return
	var keys := mix_touch_drags.keys()
	var first: Dictionary = mix_touch_drags[keys[0]]
	var second: Dictionary = mix_touch_drags[keys[1]]
	if not bool(first.get("released", false)) or not bool(second.get("released", false)):
		return
	var release_delta = absf(float(first.get("release_time", 0.0)) - float(second.get("release_time", 0.0)))
	if release_delta > MIX_RELEASE_WINDOW_SECONDS:
		mix_touch_drags.clear()
		_pulse_prompt(_t("Release both colors together."))
		return
	var first_color := String(first.get("color", ""))
	var second_color := String(second.get("color", ""))
	var mixed_color := _mixed_color_for_pair(first_color, second_color)
	if mixed_color == "":
		mix_touch_drags.clear()
		_pulse_prompt(_t("Mix two different base colors."))
		return
	var first_position: Vector2 = first.get("position", Vector2.ZERO)
	var second_position: Vector2 = second.get("position", Vector2.ZERO)
	var first_tension := _launch_tension_for_color(first_color, first_position)
	var second_tension := _launch_tension_for_color(second_color, second_position)
	if first_tension < MIN_LAUNCH_PULL_RATIO or second_tension < MIN_LAUNCH_PULL_RATIO:
		mix_touch_drags.clear()
		_pulse_prompt(_t("Pull both colors farther."))
		return
	if not _validate_mixed_launch(mixed_color):
		mix_touch_drags.clear()
		return
	var result_special_kind := ""
	if _is_mixed_launch_special(armed_special_kind):
		result_special_kind = armed_special_kind
	var batch_id := next_mix_batch_id
	next_mix_batch_id += 1
	_record_shot()
	_spawn_mixing_launcher_ball(first_color, mixed_color, batch_id, first_tension, _launch_direction_for_color(first_color, first_position), result_special_kind)
	_spawn_mixing_launcher_ball(second_color, mixed_color, batch_id, second_tension, _launch_direction_for_color(second_color, second_position), result_special_kind)
	if result_special_kind != "":
		armed_special_kind = ""
		_save_progress(current_level)
	mix_touch_drags.clear()

func _validate_mixed_launch(mixed_color: String) -> bool:
	if _remaining_target_count() <= 0:
		_pulse_prompt(_t("Level clear. Tap to continue."))
		return false
	if _shots_remaining() <= 0:
		_check_level_failed()
		if not level_failed:
			_pulse_prompt(_t("No shots left. Watch the board."))
		return false
	if _is_mixed_launch_special(armed_special_kind):
		if armed_special_kind == "missile" and _target_count_for_color(mixed_color) <= 0:
			_pulse_prompt(_t("No %s target for missile.") % _color_word(mixed_color))
			return false
		return true
	var launcher_count := _launcher_commitment_count_for_color(mixed_color)
	var allowed_count := _allowed_launcher_count_for_color(mixed_color)
	if launcher_count >= allowed_count:
		if allowed_count <= 0:
			_pulse_prompt(_t("No %s target path yet.") % _color_word(mixed_color))
		else:
			_pulse_prompt(_t("%s shots match target count.") % _color_word(mixed_color))
		return false
	return true

func _mix_active_color_count(color_name: String) -> int:
	var count := 0
	for key in mix_touch_drags.keys():
		var entry: Dictionary = mix_touch_drags[key]
		if String(entry.get("color", "")) == color_name and not bool(entry.get("released", false)):
			count += 1
	return count

func _expire_pending_mix_releases() -> void:
	if mix_touch_drags.is_empty():
		return
	var now := _now_seconds()
	var has_released := false
	var all_released := true
	var oldest_release := now
	for key in mix_touch_drags.keys():
		var entry: Dictionary = mix_touch_drags[key]
		if bool(entry.get("released", false)):
			has_released = true
			oldest_release = minf(oldest_release, float(entry.get("release_time", now)))
		else:
			all_released = false
	if has_released and not all_released and now - oldest_release > MIX_RELEASE_WINDOW_SECONDS:
		mix_touch_drags.clear()
		_pulse_prompt(_t("Release both colors together."))

func _refresh_mix_drag_layout() -> void:
	if mix_touch_drags.is_empty():
		return
	for key in mix_touch_drags.keys():
		var entry: Dictionary = mix_touch_drags[key]
		var color_name := String(entry.get("color", ""))
		var position: Vector2 = entry.get("position", Vector2.ZERO)
		entry["position"] = _drag_preview_position_for_color(position, color_name)
		mix_touch_drags[key] = entry

func _now_seconds() -> float:
	return float(Time.get_ticks_msec()) / 1000.0

func _launch_speed_for_tension(tension: float) -> float:
	var clamped := clampf(tension, 0.0, 1.0)
	var speed := lerpf(LAUNCH_MIN_SPEED, LAUNCH_MAX_SPEED, clamped)
	if clamped >= 0.999:
		speed *= FULL_CHARGE_SPEED_BONUS
	return speed

func _validate_launch_color(color_name: String) -> bool:
	if _remaining_target_count() <= 0:
		_pulse_prompt(_t("Level clear. Tap to continue."))
		return false
	if _shots_remaining() <= 0:
		_check_level_failed()
		if not level_failed:
			_pulse_prompt(_t("No shots left. Watch the board."))
		return false
	if armed_special_kind != "":
		return true
	if furball_shot_armed:
		return true

	if current_level == 1:
		if shots_fired[color_name]:
			if tutorial_step >= COLOR_ORDER.size():
				_pulse_prompt(_t("All shots fired. Watch the collisions."))
			else:
				_pulse_prompt(_t("%s is already fired.") % _color_word(color_name))
			return false
		# The order gate only applies to colors never launched this level; a
		# color re-enabled by a missed shot is always allowed to retry, and it
		# never locks the colors that come after it.
		if not tutorial_colors_fired.get(color_name, false) and tutorial_step < COLOR_ORDER.size():
			var expected_color: String = COLOR_ORDER[tutorial_step]
			if color_name != expected_color:
				_pulse_prompt(_t("%s first.") % _launch_instruction(expected_color))
				return false
		return true

	var launcher_count := _launcher_commitment_count_for_color(color_name)
	var allowed_count := _allowed_launcher_count_for_color(color_name)
	if launcher_count >= allowed_count:
		if _target_count_for_color(color_name) <= 0 and allowed_count > 0:
			_pulse_prompt(_t("One %s prediction shot only.") % _color_word(color_name))
		elif allowed_count <= 0:
			_pulse_prompt(_t("No %s target path yet.") % _color_word(color_name))
		else:
			_pulse_prompt(_t("%s shots match target count.") % _color_word(color_name))
		return false
	return true

func _launch_color(color_name: String, tension: float, launch_direction := Vector2.UP) -> void:
	if not _validate_launch_color(color_name):
		return
	if armed_special_kind != "":
		_launch_armed_special(color_name, tension, launch_direction)
		return

	if current_level == 1:
		shots_fired[color_name] = true
		tutorial_colors_fired[color_name] = true
		_refresh_tutorial_step()
	var launch_speed = _launch_speed_for_tension(tension)
	_record_shot()
	_spawn_launcher_ball(color_name, launch_speed, launch_direction, tension >= 0.999)
	if _level_has_color_mixing() and _is_primary_color(color_name):
		_pulse_prompt(_t("Solo shots can't pop mixed targets - drag onto another color to mix!"))

func _record_shot() -> void:
	shots_used += 1
	if aimer_armed and aimer_charges > 0:
		aimer_charges -= 1
		if aimer_charges <= 0:
			aimer_armed = false

func _spawn_launcher_ball(color_name: String, launch_speed: float, launch_direction: Vector2, full_charge := false) -> void:
	var center = _button_center(color_name)
	var spawn_position = Vector2(center.x, arena.position.y + arena.size.y - LAUNCH_RADIUS - 4.0)
	var velocity = launch_direction.normalized() * launch_speed
	var launcher_ball := GameBall.new(spawn_position, velocity, launch_speed, LAUNCH_RADIUS, color_name, false)
	if full_charge:
		launcher_ball.burst_settle_speed = launch_speed
		launcher_ball.speed = launch_speed * FULL_CHARGE_BURST_MULTIPLIER
		launcher_ball.velocity = launch_direction.normalized() * launcher_ball.speed
		_create_full_charge_muzzle(spawn_position, launch_direction.normalized(), color_name)
	if furball_shot_armed:
		furball_shot_armed = false
		launcher_ball.is_furball = true
		launcher_ball.radius = LAUNCH_RADIUS * PINK_FURBALL_RADIUS_SCALE
		if meow_player != null:
			meow_player.stream_paused = false
			meow_player.play()
		_save_progress(current_level)
	balls.append(launcher_ball)
	_flip_cap(color_name)
	if OS.is_debug_build():
		print("LAUNCH shot=%d usec=%d" % [shots_used, Time.get_ticks_usec()])

func _spawn_mixing_launcher_ball(color_name: String, mixed_color: String, batch_id: int, tension: float, launch_direction: Vector2, result_special_kind := "") -> void:
	var launch_speed = _launch_speed_for_tension(tension)
	var center = _button_center(color_name)
	var spawn_position = Vector2(center.x, arena.position.y + arena.size.y - LAUNCH_RADIUS - 4.0)
	var velocity = launch_direction.normalized() * launch_speed
	var ball := GameBall.new(spawn_position, velocity, launch_speed, LAUNCH_RADIUS, color_name, false)
	ball.mix_batch_id = batch_id
	ball.mix_result_color = mixed_color
	ball.mix_result_special_kind = result_special_kind
	balls.append(ball)
	_flip_cap(color_name)

func _launch_drag_mixed_color(anchor_color: String, mixed_color: String, tension: float, launch_direction: Vector2) -> void:
	if mixed_color == "":
		return
	if not _validate_mixed_launch(mixed_color):
		return
	var special_kind := armed_special_kind if _is_mixed_launch_special(armed_special_kind) else ""
	var launch_speed = _launch_speed_for_tension(tension)
	if special_kind == "missile":
		launch_speed = MISSILE_START_SPEED
	_record_shot()
	_spawn_direct_mixed_launcher_ball(anchor_color, mixed_color, special_kind, launch_speed, launch_direction)
	if special_kind != "":
		armed_special_kind = ""
		_save_progress(current_level)

func _spawn_direct_mixed_launcher_ball(anchor_color: String, mixed_color: String, special_kind: String, launch_speed: float, launch_direction: Vector2) -> void:
	var center := _button_center(anchor_color)
	var spawn_position = Vector2(center.x, arena.position.y + arena.size.y - LAUNCH_RADIUS - 4.0)
	var velocity = launch_direction.normalized() * launch_speed
	var ball := GameBall.new(spawn_position, velocity, launch_speed, LAUNCH_RADIUS * (1.06 if special_kind != "" else 1.12), mixed_color, false)
	ball.special_kind = special_kind
	ball.special_hp = CRYSTAL_BALL_HP if special_kind == "crystal" else 1
	if special_kind == "crystal":
		ball.radius = LAUNCH_RADIUS * CRYSTAL_BALL_RADIUS_SCALE
	balls.append(ball)
	_flip_cap(anchor_color)
	_create_mix_feedback(spawn_position, mixed_color)

func _launch_armed_special(origin_color: String, tension: float, launch_direction: Vector2) -> void:
	if armed_special_kind == "":
		return
	if _remaining_target_count() <= 0:
		_pulse_prompt(_t("Level clear. Tap to continue."))
		return
	if _shots_remaining() <= 0:
		_check_level_failed()
		if not level_failed:
			_pulse_prompt(_t("No shots left. Watch the board."))
		return
	var special_kind := armed_special_kind
	if special_kind == "missile" and _target_count_for_color(origin_color) <= 0:
		_pulse_prompt(_t("No %s target for missile.") % _color_word(origin_color))
		return
	var launch_speed = _launch_speed_for_tension(tension)
	_record_shot()
	_spawn_special_ball(origin_color, special_kind, launch_speed, launch_direction)
	armed_special_kind = ""
	_save_progress(current_level)

func _consume_armed_special_stock(special_kind: String) -> bool:
	if special_kind == "crystal":
		if crystal_stock <= 0:
			_pulse_prompt(_t("No crystal balls."))
			return false
		crystal_stock -= 1
		return true
	if special_kind == "antimatter":
		if antimatter_stock <= 0:
			_pulse_prompt(_t("No antimatter balls."))
			return false
		antimatter_stock -= 1
		return true
	if special_kind == "missile":
		if missile_stock <= 0:
			_pulse_prompt(_t("No missiles."))
			return false
		missile_stock -= 1
		return true
	return false

func _spawn_special_ball(origin_color: String, special_kind: String, launch_speed: float, launch_direction: Vector2) -> void:
	var center = _button_center(origin_color)
	var spawn_position = Vector2(center.x, arena.position.y + arena.size.y - LAUNCH_RADIUS - 4.0)
	if special_kind == "missile":
		launch_speed = MISSILE_START_SPEED
	var velocity = launch_direction.normalized() * launch_speed
	var color_name := origin_color
	if special_kind == "crystal":
		color_name = "crystal"
	elif special_kind == "antimatter":
		color_name = "antimatter"
	var special_ball := GameBall.new(spawn_position, velocity, launch_speed, LAUNCH_RADIUS * 1.06, color_name, false)
	special_ball.special_kind = special_kind
	special_ball.special_hp = CRYSTAL_BALL_HP if special_kind == "crystal" else 1
	if special_kind == "crystal":
		special_ball.radius = LAUNCH_RADIUS * CRYSTAL_BALL_RADIUS_SCALE
	balls.append(special_ball)
	_flip_cap(origin_color)

func _launch_instruction(color_name: String) -> String:
	return _t("Pull %s down/sideways") % _color_word(color_name)

func _weak_launch_prompt() -> String:
	return _t("Pull down farther, then release.")

func _drag_preview_position(position: Vector2) -> Vector2:
	return _clamped_pull_position(position)

func _drag_preview_position_for_color(position: Vector2, color_name: String) -> Vector2:
	return _clamped_pull_position_for_color(position, color_name)

func _clamped_pull_position(position: Vector2) -> Vector2:
	return _clamped_pull_position_for_color(position, drag_color)

func _clamped_pull_position_for_color(position: Vector2, color_name: String) -> Vector2:
	if color_name == "":
		return position
	var center = _button_center(color_name)
	var max_pull = button_radius * MAX_PULL_RADIUS_MULTIPLIER
	var max_side_pull = max_pull * tan(deg_to_rad(MAX_LAUNCH_ANGLE_DEGREES))
	var viewport_size := get_viewport_rect().size
	return Vector2(
		clampf(position.x, maxf(LAUNCH_RADIUS, center.x - max_side_pull), minf(viewport_size.x - LAUNCH_RADIUS, center.x + max_side_pull)),
		clampf(position.y, center.y, center.y + max_pull)
	)

func _current_pull() -> float:
	if not drag_active or drag_color == "":
		return 0.0
	var center = _button_center(drag_color)
	return maxf(drag_position.y - center.y, 0.0)

func _launch_tension() -> float:
	if drag_color == "":
		return 0.0
	return _pull_tension()

func _launch_tension_for_color(color_name: String, position: Vector2) -> float:
	if color_name == "":
		return 0.0
	var max_pull = button_radius * MAX_PULL_RADIUS_MULTIPLIER
	if max_pull <= 0.0:
		return 0.0
	var center = _button_center(color_name)
	return clampf(maxf(position.y - center.y, 0.0) / max_pull, 0.0, 1.0)

func _launch_direction() -> Vector2:
	return _launch_direction_for_color(drag_color, drag_position)

func _launch_direction_for_color(color_name: String, position: Vector2) -> Vector2:
	if color_name == "":
		return Vector2.UP
	var center = _button_center(color_name)
	var pull = position - center
	var vertical_pull = maxf(pull.y, 0.0)
	if vertical_pull <= 0.001:
		return Vector2.UP
	var max_horizontal = vertical_pull * tan(deg_to_rad(MAX_LAUNCH_ANGLE_DEGREES))
	var horizontal = clampf(-pull.x, -max_horizontal, max_horizontal)
	return Vector2(horizontal, -vertical_pull).normalized()

func _pull_tension() -> float:
	var max_pull = button_radius * MAX_PULL_RADIUS_MULTIPLIER
	if max_pull <= 0.0:
		return 0.0
	return clampf(_current_pull() / max_pull, 0.0, 1.0)

func _step_balls(delta: float) -> void:
	_step_merged_target_spikes(delta)
	_step_wall_flashes(delta)
	_step_cap_flips(delta)
	_update_missile_flight_audio()
	for ball in balls:
		if ball.swallow_timer >= 0.0:
			continue
		_step_wall_recolor_cooldown(ball, delta)
		if ball.special_kind == "missile":
			_step_missile_tracking(ball, delta)
			if not ball.is_target:
				_emit_missile_trail(ball)
		if ball.is_target and target_freeze_timer > 0.0:
			continue
		if ball.burst_settle_speed > 0.0:
			var settled := maxf(ball.burst_settle_speed, ball.speed * maxf(0.0, 1.0 - FULL_CHARGE_BURST_DECAY * delta))
			ball.speed = settled
			ball.velocity = ball.velocity.normalized() * settled
			_emit_burst_trail(ball)
			if ball.speed <= ball.burst_settle_speed + 0.5:
				ball.burst_settle_speed = -1.0
		elif _ball_speed_decays(ball):
			var drag_factor := maxf(0.0, 1.0 - PLAYER_BALL_DRAG_PER_SECOND * delta)
			ball.speed *= drag_factor
			ball.velocity *= drag_factor
		ball.position += ball.velocity * delta
		ball.spin_angle += ball.spin_velocity * delta
		ball.spin_velocity *= maxf(0.0, 1.0 - 0.5 * delta)
		_resolve_wall_collision(ball)

	_step_swallowed_balls(delta)
	_resolve_black_hole_collisions()
	_enforce_launcher_color_caps()
	_resolve_ball_collisions()
	_expire_spent_launcher_balls()

func _step_black_hole(delta: float) -> void:
	if not _level_has_black_holes() or not black_hole_enabled or level_complete or level_failed:
		return
	if black_hole_respawn_cooldown > 0.0:
		black_hole_respawn_cooldown = maxf(black_hole_respawn_cooldown - delta, 0.0)
		if black_hole_respawn_cooldown > 0.0:
			return
	black_hole_timer -= delta
	if not black_hole_active or black_hole_timer <= 0.0:
		_spawn_black_hole()

func _step_missile_tracking(missile_ball: GameBall, delta := 0.0) -> void:
	var target = _missile_target_for(missile_ball)
	if target == null:
		return
	var direction: Vector2 = target.position - missile_ball.position
	if direction.length_squared() < 0.001:
		return
	missile_ball.speed = minf(missile_ball.speed + MISSILE_ACCEL * delta, MISSILE_MAX_SPEED)
	missile_ball.velocity = direction.normalized() * missile_ball.speed

func _emit_missile_trail(ball: GameBall) -> void:
	if particles.size() > 260 or ball.velocity.length_squared() < 0.001:
		return
	var direction := (ball.velocity as Vector2).normalized()
	var side := Vector2(-direction.y, direction.x)
	for index in range(2):
		var tail_position: Vector2 = ball.position - direction * ball.radius * (1.15 + rng.randf_range(0.0, 0.4)) + side * rng.randf_range(-3.0, 3.0)
		var puff_velocity: Vector2 = -direction * rng.randf_range(50.0, 130.0) + side * rng.randf_range(-24.0, 24.0)
		var puff_color := Color("#ff8f2a").lerp(Color("#fff6cc"), rng.randf_range(0.0, 0.65))
		puff_color.a = 0.85
		particles.append(BurstParticle.new(tail_position, puff_velocity, puff_color, rng.randf_range(2.2, 4.6), "puff", 0.30))
	var smoke_position: Vector2 = ball.position - direction * ball.radius * (1.8 + rng.randf_range(0.0, 0.6)) + side * rng.randf_range(-4.0, 4.0)
	var smoke_velocity: Vector2 = -direction * rng.randf_range(24.0, 60.0) + side * rng.randf_range(-16.0, 16.0)
	var smoke_shade := rng.randf_range(0.46, 0.62)
	particles.append(BurstParticle.new(smoke_position, smoke_velocity, Color(smoke_shade, smoke_shade * 0.97, smoke_shade * 0.94, 0.50), rng.randf_range(3.4, 6.2), "puff", 0.60))
	if rng.randf() < 0.35:
		var spark_velocity: Vector2 = -direction * rng.randf_range(180.0, 320.0) + side * rng.randf_range(-60.0, 60.0)
		particles.append(BurstParticle.new(ball.position - direction * ball.radius, spark_velocity, Color("#ffd27a"), 1.8, "spark", 0.24))

func _missile_target_for(missile_ball: GameBall):
	var best_ball = null
	var best_distance := 1000000000.0
	for ball in balls:
		if not ball.is_target or ball.color_name != missile_ball.color_name:
			continue
		var distance := missile_ball.position.distance_squared_to(ball.position)
		if distance < best_distance:
			best_distance = distance
			best_ball = ball
	return best_ball

func _level_has_black_holes() -> bool:
	return current_level >= BLACK_HOLE_LEVEL_START and (current_level < TARGET_MERGE_LEVEL_START or current_level >= TARGET_MERGE_BLACK_HOLE_LEVEL_START) and (current_level < COLOR_MIX_LEVEL_START or current_level >= COLOR_MIX_BLACK_HOLE_LEVEL_START)

func _level_has_target_merging() -> bool:
	return current_level >= TARGET_MERGE_LEVEL_START

func _level_has_color_mixing() -> bool:
	return current_level >= COLOR_MIX_LEVEL_START

func _spawn_black_hole() -> void:
	black_hole_active = true
	black_hole_timer = BLACK_HOLE_REFRESH_SECONDS
	black_hole_position = _random_black_hole_position()

func _random_black_hole_position() -> Vector2:
	var spawn_bounds := _black_hole_spawn_bounds()
	var best_position := _random_position_in_rect(spawn_bounds)
	var best_gap := _black_hole_spawn_gap(best_position)

	for attempt in range(BLACK_HOLE_SPAWN_ATTEMPTS):
		var candidate := _random_position_in_rect(spawn_bounds)
		var gap := _black_hole_spawn_gap(candidate)
		if gap >= BLACK_HOLE_SPAWN_CLEARANCE:
			return candidate
		if gap > best_gap:
			best_position = candidate
			best_gap = gap
	return best_position

func _black_hole_spawn_bounds() -> Rect2:
	var inset := BLACK_HOLE_RADIUS + TARGET_RADIUS
	var min_position := arena.position + Vector2(inset, inset)
	var max_position := arena.position + arena.size - Vector2(inset, inset)
	var launch_spawn_y := arena.position.y + arena.size.y - LAUNCH_RADIUS - 4.0
	var launcher_safe_y := launch_spawn_y - BLACK_HOLE_RADIUS - LAUNCH_RADIUS - BLACK_HOLE_BOTTOM_LAUNCH_CLEARANCE
	max_position.y = minf(max_position.y, launcher_safe_y)
	max_position.x = maxf(max_position.x, min_position.x)
	max_position.y = maxf(max_position.y, min_position.y)
	return Rect2(min_position, max_position - min_position)

func _random_position_in_rect(rect: Rect2) -> Vector2:
	return Vector2(
		rng.randf_range(rect.position.x, rect.position.x + rect.size.x),
		rng.randf_range(rect.position.y, rect.position.y + rect.size.y)
	)

func _black_hole_spawn_gap(position: Vector2) -> float:
	var nearest_gap := 1000000.0
	for ball in balls:
		var gap := position.distance_to(ball.position) - BLACK_HOLE_RADIUS - ball.radius
		nearest_gap = minf(nearest_gap, gap)
	return nearest_gap

func _step_merged_target_spikes(delta: float) -> void:
	for ball in balls:
		if not ball.is_target or not ball.merged_target:
			continue
		ball.spike_timer -= delta
		if ball.spike_timer > 0.0:
			continue
		match ball.spike_state:
			"out":
				ball.spike_state = "retract"
				ball.spike_timer = SPIKE_RETRACT_SECONDS
			"retract":
				ball.spike_state = "cooldown"
				ball.spike_timer = SPIKE_COOLDOWN_SECONDS
			_:
				ball.spike_state = "out"
				ball.spike_timer = SPIKE_OUT_SECONDS
				ball.spike_count = SPIKE_COUNT_MAX

func _spike_extension(ball: GameBall) -> float:
	if ball.spike_state == "out":
		var elapsed: float = SPIKE_OUT_SECONDS - ball.spike_timer
		return clampf(elapsed / SPIKE_RETRACT_SECONDS, 0.0, 1.0)
	if ball.spike_state == "retract":
		return clampf(ball.spike_timer / SPIKE_RETRACT_SECONDS, 0.0, 1.0)
	return 0.0

func _target_spikes_active(ball: GameBall) -> bool:
	return ball.is_target and ball.merged_target and ball.spike_state == "out" and ball.spike_count > 0

func _resolve_black_hole_collisions() -> void:
	if not black_hole_active:
		return
	var survivors: Array[GameBall] = []
	for ball in balls:
		if ball.is_target or ball.swallow_timer >= 0.0:
			survivors.append(ball)
			continue
		if ball.position.distance_to(black_hole_position) > ball.radius + BLACK_HOLE_RADIUS:
			survivors.append(ball)
			continue
		if ball.is_furball:
			ball.collision_count += 1
			_destroy_black_hole(ball.position)
			survivors.append(ball)
			continue
		if ball.special_kind == "antimatter":
			_destroy_black_hole(ball.position)
			continue
		ball.swallow_timer = 0.0
		ball.swallow_base_radius = ball.radius
		_play_swallow_sound()
		survivors.append(ball)
	balls = survivors

func _step_swallowed_balls(delta: float) -> void:
	var has_swallowed := false
	for ball in balls:
		if ball.swallow_timer >= 0.0:
			has_swallowed = true
			break
	if not has_swallowed:
		return
	var survivors: Array[GameBall] = []
	for ball in balls:
		if ball.swallow_timer < 0.0:
			survivors.append(ball)
			continue
		ball.swallow_timer += delta
		var offset: Vector2 = ball.position - black_hole_position
		offset = offset.rotated(delta * 9.0) * maxf(0.0, 1.0 - delta * 8.0)
		ball.position = black_hole_position + offset
		ball.spin_angle += delta * 14.0
		var swallow_scale := 1.0
		if ball.swallow_timer < BLACK_HOLE_SWALLOW_PHASE_1:
			swallow_scale = lerpf(1.0, 0.6, ball.swallow_timer / BLACK_HOLE_SWALLOW_PHASE_1)
		elif ball.swallow_timer < BLACK_HOLE_SWALLOW_SECONDS:
			swallow_scale = lerpf(0.6, 0.2, (ball.swallow_timer - BLACK_HOLE_SWALLOW_PHASE_1) / (BLACK_HOLE_SWALLOW_SECONDS - BLACK_HOLE_SWALLOW_PHASE_1))
		else:
			_create_black_hole_feedback(black_hole_position, false)
			continue
		ball.radius = ball.swallow_base_radius * swallow_scale
		survivors.append(ball)
	balls = survivors

func _destroy_black_hole(impact_position: Vector2) -> void:
	black_hole_active = false
	black_hole_timer = BLACK_HOLE_REFRESH_SECONDS
	black_hole_respawn_cooldown = BLACK_HOLE_ANTIMATTER_RESPAWN_DELAY
	_play_sfx(SFX_ANTIMATTER_STREAM)
	_create_black_hole_feedback(impact_position, true)
	_pulse_prompt(_t("Black hole suppressed 20s."))

func _create_black_hole_feedback(position: Vector2, neutralized: bool) -> void:
	var base_color := Color("#f7f7f7") if neutralized else Color("#161616")
	for index in range(22):
		var angle = rng.randf_range(0.0, TAU)
		var speed = rng.randf_range(80.0, 230.0)
		var particle_color = base_color.lerp(Color("#78ddff"), rng.randf_range(0.0, 0.36))
		particle_color.a = 0.86
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(angle) * speed, particle_color, rng.randf_range(2.8, 6.0)))

func _step_wall_recolor_cooldown(ball: GameBall, delta: float) -> void:
	if ball.wall_recolor_cooldown <= 0.0:
		return
	ball.wall_recolor_cooldown = maxf(ball.wall_recolor_cooldown - delta, 0.0)

func _resolve_wall_collision(ball: GameBall) -> void:
	var bounced := false
	var hit_floor := false
	var wall_color := ""
	var wall_normal := Vector2.ZERO
	var left_bound: float = arena.position.x + wall_tube_inset
	var right_bound: float = arena.position.x + arena.size.x - wall_tube_inset
	if ball.position.x - ball.radius < left_bound:
		ball.position.x = left_bound + ball.radius
		ball.velocity.x = absf(ball.velocity.x)
		bounced = true
		wall_normal = Vector2.RIGHT
		wall_color = _wall_color_for_side_y(LEFT_WALL_COLORS, ball.position.y)
		_flash_wall_tube("left", ball.position.y)
	elif ball.position.x + ball.radius > right_bound:
		ball.position.x = right_bound - ball.radius
		ball.velocity.x = -absf(ball.velocity.x)
		bounced = true
		wall_normal = Vector2.LEFT
		wall_color = _wall_color_for_side_y(RIGHT_WALL_COLORS, ball.position.y)
		_flash_wall_tube("right", ball.position.y)

	if ball.position.y - ball.radius < arena.position.y:
		ball.position.y = arena.position.y + ball.radius
		ball.velocity.y = absf(ball.velocity.y)
		bounced = true
		wall_normal = Vector2.DOWN
	elif ball.position.y + ball.radius > arena.position.y + arena.size.y:
		ball.position.y = arena.position.y + arena.size.y - ball.radius
		ball.velocity.y = -absf(ball.velocity.y)
		bounced = true
		hit_floor = true
		wall_normal = Vector2.UP

	if wall_color != "":
		_recolor_ball_from_wall(ball, wall_color)
	if bounced:
		ball.spin_velocity = -ball.velocity.cross(wall_normal) / maxf(ball.radius, 1.0) * 0.85
	if bounced and not ball.is_target:
		ball.collision_count += 1
		if _ball_speed_decays(ball):
			ball.speed *= PLAYER_BALL_BOUNCE_RESTITUTION
			if ball.speed <= PLAYER_BALL_MIN_ALIVE_SPEED:
				ball.speed = 0.0
		if not hit_floor:
			_play_wall_bounce_sound(clampf(ball.velocity.length() / LAUNCH_MAX_SPEED, 0.35, 1.0))
			if ball.special_kind == "crystal":
				ball.special_hp -= 1
				_spawn_hp_change_text(str(maxi(ball.special_hp, 0)), ball.position, Color("#f8ffff"))
	_keep_ball_speed(ball)

func _register_ui_press(button_id: String, with_sound := true) -> void:
	ui_press_flash[button_id] = UI_PRESS_SECONDS
	if with_sound:
		_play_ui_click_sound()
	queue_redraw()

func _step_ui_press_flash(delta: float) -> void:
	for key in ui_press_flash.keys():
		var remaining: float = float(ui_press_flash[key]) - delta
		if remaining <= 0.0:
			ui_press_flash.erase(key)
		else:
			ui_press_flash[key] = remaining
	_step_powerup_press_zoom(delta)

func _powerup_slot_held(slot_id: String) -> bool:
	return powerup_touch_active and not powerup_touch_dragging and not powerup_touch_blocked and powerup_touch_candidate_id == slot_id

func _step_powerup_press_zoom(delta: float) -> void:
	var held_id := powerup_touch_candidate_id if _powerup_slot_held(powerup_touch_candidate_id) else ""
	if held_id != "" and not powerup_press_zoom.has(held_id):
		powerup_press_zoom[held_id] = 1.0
	for key in powerup_press_zoom.keys():
		var target: float = 1.2 if String(key) == held_id else 1.0
		var current: float = float(powerup_press_zoom[key])
		if target > current:
			current = minf(target, current + delta * (0.2 / 0.06))
		else:
			current = maxf(target, current - delta * (0.2 / 0.09))
		if current <= 1.001 and target <= 1.0:
			powerup_press_zoom.erase(key)
		else:
			powerup_press_zoom[key] = current
			queue_redraw()

func _ui_press_rect(button_id: String, rect: Rect2) -> Rect2:
	if not ui_press_flash.has(button_id):
		return rect
	return Rect2(rect.position + rect.size * 0.04, rect.size * 0.92)

func _play_ui_click_sound() -> void:
	if audio_player == null:
		return
	var playback = audio_player.get_stream_playback() as AudioStreamGeneratorPlayback
	if playback == null:
		return
	var frames := int(AUDIO_MIX_RATE * 0.045)
	for index in range(frames):
		var t := float(index) / AUDIO_MIX_RATE
		var envelope := exp(-t * 90.0)
		var sample := (sin(TAU * 1350.0 * t) * 0.6 + sin(TAU * 2400.0 * t) * 0.25) * envelope * 0.5
		playback.push_frame(Vector2(sample, sample))

func _play_wall_bounce_sound(intensity: float) -> void:
	if audio_player == null or wall_sound_timer > 0.0:
		return
	var playback = audio_player.get_stream_playback() as AudioStreamGeneratorPlayback
	if playback == null:
		return
	var frames = mini(int(AUDIO_MIX_RATE * 0.16), playback.get_frames_available())
	if frames <= 256:
		return
	wall_sound_timer = WALL_SOUND_MIN_INTERVAL
	var strength = clampf(intensity, 0.0, 1.0)
	var bell_frequency = rng.randf_range(1180.0, 1290.0)
	var volume = lerpf(0.16, 0.32, strength)
	for frame in range(frames):
		var t = float(frame) / float(AUDIO_MIX_RATE)
		var snap = rng.randf_range(-1.0, 1.0) * exp(-t * 520.0) * 0.55
		var bell = sin(TAU * bell_frequency * t) * exp(-t * 22.0) * 0.62
		bell += sin(TAU * bell_frequency * 2.32 * t) * exp(-t * 34.0) * 0.40
		bell += sin(TAU * bell_frequency * 3.86 * t) * exp(-t * 52.0) * 0.24
		var body = sin(TAU * 420.0 * t) * exp(-t * 60.0) * 0.30
		var sample = clampf((snap + bell + body) * volume, -1.0, 1.0)
		playback.push_frame(Vector2(sample, sample))

func _play_swallow_sound() -> void:
	if audio_player == null:
		return
	var playback = audio_player.get_stream_playback() as AudioStreamGeneratorPlayback
	if playback == null:
		return
	var frames = mini(int(AUDIO_MIX_RATE * 0.42), playback.get_frames_available())
	if frames <= 256:
		return
	var phase := 0.0
	var duration := float(frames) / float(AUDIO_MIX_RATE)
	for frame in range(frames):
		var t = float(frame) / float(AUDIO_MIX_RATE)
		var progress = t / duration
		var sweep_frequency = lerpf(760.0, 68.0, pow(progress, 0.55))
		phase += TAU * sweep_frequency / AUDIO_MIX_RATE
		var wobble = 1.0 + 0.22 * sin(TAU * 13.0 * t)
		var body = sin(phase * wobble) * 0.55
		var whoosh = rng.randf_range(-1.0, 1.0) * (1.0 - progress) * 0.28
		var rumble = sin(TAU * 46.0 * t) * progress * 0.35
		var envelope = minf(t / 0.02, 1.0) * (1.0 - pow(progress, 3.0))
		var sample = clampf((body + whoosh + rumble) * envelope * 0.6, -1.0, 1.0)
		playback.push_frame(Vector2(sample, sample))

func _play_warning_sound() -> void:
	if audio_player == null:
		return
	var playback = audio_player.get_stream_playback() as AudioStreamGeneratorPlayback
	if playback == null:
		return
	var frames := int(AUDIO_MIX_RATE * 0.52)
	for index in range(frames):
		var t := float(index) / AUDIO_MIX_RATE
		var pulse_t := -1.0
		if t < 0.20:
			pulse_t = t
		elif t >= 0.28 and t < 0.50:
			pulse_t = t - 0.28
		if pulse_t < 0.0:
			playback.push_frame(Vector2.ZERO)
			continue
		var envelope := minf(pulse_t / 0.012, 1.0) * exp(-pulse_t * 9.0)
		var sample := (sin(TAU * 392.0 * pulse_t) * 0.5 + sin(TAU * 466.16 * pulse_t) * 0.5 + sin(TAU * 196.0 * pulse_t) * 0.35) * envelope * 0.55
		playback.push_frame(Vector2(sample, sample))

func _play_powerup_press_sound() -> void:
	if audio_player == null:
		return
	var playback = audio_player.get_stream_playback() as AudioStreamGeneratorPlayback
	if playback == null:
		return
	var frames := int(AUDIO_MIX_RATE * 0.12)
	for index in range(frames):
		var t := float(index) / AUDIO_MIX_RATE
		var sample := sin(TAU * 523.25 * t) * 0.30 * exp(-t * 34.0)
		if t > 0.035:
			var t2 := t - 0.035
			sample += (sin(TAU * 784.0 * t2) * 0.34 + sin(TAU * 1568.0 * t2) * 0.13) * exp(-t2 * 26.0)
		playback.push_frame(Vector2(sample, sample))

func _flash_wall_tube(side: String, y_position: float) -> void:
	var segment := clampi(int((y_position - arena.position.y) / maxf(arena.size.y / 3.0, 1.0)), 0, 2)
	wall_flash_timers["%s_%d" % [side, segment]] = WALL_FLASH_SECONDS

func _step_wall_flashes(delta: float) -> void:
	for key in wall_flash_timers.keys():
		var remaining: float = float(wall_flash_timers[key]) - delta
		if remaining <= 0.0:
			wall_flash_timers.erase(key)
		else:
			wall_flash_timers[key] = remaining

func _flip_cap(color_name: String) -> void:
	if COLOR_ORDER.has(color_name):
		cap_flip_timers[color_name] = CAP_FLIP_SECONDS

func _step_cap_flips(delta: float) -> void:
	for key in cap_flip_timers.keys():
		var remaining: float = float(cap_flip_timers[key]) - delta
		if remaining <= 0.0:
			cap_flip_timers.erase(key)
		else:
			cap_flip_timers[key] = remaining
	for color_name in COLOR_ORDER:
		var target: float = 1.0 if (_launcher_ball_pulled(color_name) or cap_flip_timers.has(color_name)) else 0.0
		var current: float = float(cap_openness.get(color_name, 0.0))
		if target > current:
			current = minf(target, current + delta / 0.14)
		else:
			current = maxf(target, current - delta / 0.20)
		cap_openness[color_name] = current

func _resolve_ball_collisions() -> void:
	var removed := {}

	for i in range(balls.size()):
		if removed.has(i):
			continue
		for j in range(i + 1, balls.size()):
			if removed.has(j):
				continue

			var a = balls[i]
			var b = balls[j]
			if a.swallow_timer >= 0.0 or b.swallow_timer >= 0.0:
				continue
			var delta = b.position - a.position
			var distance = delta.length()
			var min_distance = a.radius + b.radius
			if distance > min_distance:
				continue

			if _can_mix_launcher_pair(a, b):
				var mix_position = (a.position + b.position) * 0.5
				_mix_launcher_pair(a, b, j, mix_position, removed)
				continue

			if _can_mix_target_pair(a, b):
				var target_mix_position = (a.position + b.position) * 0.5
				_mix_target_pair(a, b, j, target_mix_position, removed)
				continue

			if _can_merge_target_pair(a, b):
				var merge_position = (a.position + b.position) * 0.5
				_merge_target_pair(a, b, j, merge_position, removed)
				continue

			if _furball_hits_target(a, b):
				_resolve_furball_hit(a, b, i, j, removed)
				continue

			if _spiked_target_blocks(a, b):
				var spike_impact = (a.position + b.position) * 0.5
				_resolve_spike_hit(a, b, i, j, spike_impact, removed)
				continue

			if _can_pop_pair(a, b):
				var impact_position = (a.position + b.position) * 0.5
				_play_collision_sound(_ball_collision_intensity(a, b))
				_resolve_launcher_target_hit(a, b, i, j, impact_position, removed)
				continue

			if _should_ignore_missile_collision(a, b):
				continue

			_bounce_different_colors(a, b, delta, distance, min_distance)

	if removed.is_empty():
		return

	var survivors: Array[GameBall] = []
	for index in range(balls.size()):
		if not removed.has(index):
			survivors.append(balls[index])
	balls = survivors
	_enforce_launcher_color_caps()
	_check_level_complete()

func _furball_hits_target(a: GameBall, b: GameBall) -> bool:
	if a.is_target == b.is_target:
		return false
	var launcher_ball := a if not a.is_target else b
	return launcher_ball.is_furball

func _resolve_furball_hit(a: GameBall, b: GameBall, index_a: int, index_b: int, removed: Dictionary) -> void:
	var furball := a if not a.is_target else b
	if furball.furball_life < 0.0:
		furball.furball_life = PINK_FURBALL_LIFETIME
	var target_ball := b if not a.is_target else a
	var target_index := index_b if not a.is_target else index_a
	furball.collision_count += 1
	_create_explosion(target_ball.position, target_ball.color_name)
	removed[target_index] = true

func _spiked_target_blocks(a: GameBall, b: GameBall) -> bool:
	if a.is_target == b.is_target:
		return false
	var launcher_ball := a if not a.is_target else b
	var target_ball := b if not a.is_target else a
	if launcher_ball.special_kind == "missile":
		return false
	return _target_spikes_active(target_ball)

func _resolve_spike_hit(a: GameBall, b: GameBall, index_a: int, index_b: int, impact_position: Vector2, removed: Dictionary) -> void:
	var launcher_ball := a if not a.is_target else b
	var launcher_index := index_a if not a.is_target else index_b
	var target_ball := b if not a.is_target else a
	target_ball.spike_count = maxi(target_ball.spike_count - 1, 0)
	if launcher_ball.special_kind == "crystal":
		launcher_ball.collision_count += 1
		_create_explosion(impact_position, launcher_ball.color_name)
		_crystal_absorb_impact(launcher_ball, launcher_index, removed)
		if not removed.has(launcher_index):
			_separate_surviving_launcher_from_target(launcher_ball, target_ball)
		return
	_create_explosion(impact_position, launcher_ball.color_name)
	removed[launcher_index] = true

func _crystal_absorb_impact(crystal_ball: GameBall, crystal_index: int, removed: Dictionary) -> void:
	crystal_ball.special_hp -= 1
	_spawn_hp_change_text(str(maxi(crystal_ball.special_hp, 0)), crystal_ball.position, Color("#f8ffff"))
	if crystal_ball.special_hp <= 0:
		removed[crystal_index] = true
		_create_crystal_shatter(crystal_ball.position, crystal_ball.radius)
		_play_sfx(SFX_GLASS_SHATTER_STREAM)

func _should_ignore_missile_collision(a: GameBall, b: GameBall) -> bool:
	var missile_ball = null
	var other_ball = null
	if not a.is_target and a.special_kind == "missile":
		missile_ball = a
		other_ball = b
	elif not b.is_target and b.special_kind == "missile":
		missile_ball = b
		other_ball = a
	else:
		return false
	return not (other_ball.is_target and other_ball.color_name == missile_ball.color_name)

func _can_mix_launcher_pair(a: GameBall, b: GameBall) -> bool:
	if not _level_has_color_mixing() or a.is_target or b.is_target:
		return false
	if a.special_kind != "" or b.special_kind != "":
		return false
	if a.mix_batch_id <= 0 or a.mix_batch_id != b.mix_batch_id:
		return false
	if a.color_name == b.color_name:
		return false
	return _mixed_color_for_pair(a.color_name, b.color_name) == a.mix_result_color and a.mix_result_color == b.mix_result_color

func _mix_launcher_pair(ball_a: GameBall, ball_b: GameBall, removed_index: int, impact_position: Vector2, removed: Dictionary) -> void:
	var mixed_color := ball_a.mix_result_color
	ball_a.position = impact_position
	ball_a.color_name = mixed_color
	ball_a.radius = LAUNCH_RADIUS * 1.12
	var result_special_kind := ball_a.mix_result_special_kind
	ball_a.mix_batch_id = 0
	ball_a.mix_result_color = ""
	ball_a.mix_result_special_kind = ""
	var mixed_speed := clampf((ball_a.speed + ball_b.speed) * 0.5, LAUNCH_MIN_SPEED, LAUNCH_MAX_SPEED)
	if result_special_kind != "":
		ball_a.special_kind = result_special_kind
		ball_a.special_hp = CRYSTAL_BALL_HP if result_special_kind == "crystal" else 1
		if result_special_kind == "crystal":
			ball_a.radius = LAUNCH_RADIUS * CRYSTAL_BALL_RADIUS_SCALE
		if result_special_kind == "missile":
			mixed_speed = MISSILE_START_SPEED
	var direction := ball_a.velocity + ball_b.velocity
	if direction.length_squared() < 0.001:
		direction = Vector2.UP.rotated(rng.randf_range(-0.55, 0.55))
	ball_a.speed = mixed_speed
	ball_a.velocity = direction.normalized() * mixed_speed
	_clamp_ball_inside_arena(ball_a)
	removed[removed_index] = true
	_create_mix_feedback(impact_position, mixed_color)

func _can_mix_target_pair(a: GameBall, b: GameBall) -> bool:
	if not _level_has_color_mixing() or not a.is_target or not b.is_target:
		return false
	if a.merged_target or b.merged_target:
		return false
	if a.color_name == b.color_name:
		return false
	return _mixed_color_for_pair(a.color_name, b.color_name) != ""

func _mix_target_pair(target_a: GameBall, target_b: GameBall, removed_index: int, impact_position: Vector2, removed: Dictionary) -> void:
	var mixed_color := _mixed_color_for_pair(target_a.color_name, target_b.color_name)
	target_a.position = impact_position
	target_a.color_name = mixed_color
	target_a.hp = maxi(target_a.hp, target_b.hp)
	target_a.max_hp = maxi(target_a.max_hp, target_b.max_hp)
	target_a.wall_charge_count = 0
	target_a.wall_recolor_cooldown = 0.0
	var mixed_speed := clampf((target_a.speed + target_b.speed) * 0.5, BASE_SPEED * TARGET_SPEED_MULTIPLIER * 0.75, BASE_SPEED * TARGET_SPEED_MULTIPLIER * 1.45)
	var direction := target_a.velocity + target_b.velocity
	if direction.length_squared() < 0.001:
		direction = Vector2.RIGHT.rotated(rng.randf_range(0.0, TAU))
	target_a.speed = mixed_speed
	target_a.velocity = direction.normalized() * mixed_speed
	_clamp_ball_inside_arena(target_a)
	removed[removed_index] = true
	_create_mix_feedback(impact_position, mixed_color)

func _can_merge_target_pair(a: GameBall, b: GameBall) -> bool:
	if not _level_has_target_merging() or not a.is_target or not b.is_target:
		return false
	if a.merged_target or b.merged_target or a.color_name != b.color_name:
		return false
	if _level_has_color_mixing():
		return _is_mixed_color(a.color_name)
	return true

func _merge_target_pair(target_a: GameBall, target_b: GameBall, removed_index: int, impact_position: Vector2, removed: Dictionary) -> void:
	target_a.position = impact_position
	target_a.radius = TARGET_RADIUS * MERGED_TARGET_RADIUS_MULTIPLIER
	target_a.max_hp = maxi(TARGET_HP_MAX, maxi(target_a.max_hp, target_b.max_hp))
	target_a.hp = TARGET_HP_MAX
	target_a.wall_charge_count = maxi(target_a.wall_charge_count, target_b.wall_charge_count)
	target_a.merged_target = true
	target_a.spike_state = "out"
	target_a.spike_timer = SPIKE_OUT_SECONDS
	target_a.spike_count = SPIKE_COUNT_MAX
	var merged_speed := clampf((target_a.speed + target_b.speed) * 0.5, MERGED_TARGET_MIN_SPEED, MERGED_TARGET_MAX_SPEED)
	var direction := target_a.velocity + target_b.velocity
	if direction.length_squared() < 0.001:
		direction = Vector2.RIGHT.rotated(rng.randf_range(0.0, TAU))
	target_a.speed = merged_speed
	target_a.velocity = direction.normalized() * merged_speed
	_clamp_ball_inside_arena(target_a)
	removed[removed_index] = true
	_create_merge_feedback(impact_position, target_a.color_name)

func _clamp_ball_inside_arena(ball: GameBall) -> void:
	ball.position.x = clampf(ball.position.x, arena.position.x + ball.radius, arena.position.x + arena.size.x - ball.radius)
	ball.position.y = clampf(ball.position.y, arena.position.y + ball.radius, arena.position.y + arena.size.y - ball.radius)

func _create_mix_feedback(position: Vector2, color_name: String) -> void:
	var base_color: Color = COLOR_VALUES[color_name]
	_spawn_hp_change_text("MIX", position, base_color.lightened(0.18))
	for index in range(14):
		var angle = rng.randf_range(0.0, TAU)
		var speed = rng.randf_range(80.0, 220.0)
		var particle_color = base_color.lerp(Color.WHITE, rng.randf_range(0.12, 0.46))
		particle_color.a = 0.88
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(angle) * speed, particle_color, rng.randf_range(3.0, 6.8)))

func _create_merge_feedback(position: Vector2, color_name: String) -> void:
	var base_color: Color = COLOR_VALUES[color_name]
	_spawn_hp_change_text("BIG", position, base_color.lightened(0.16))
	for index in range(16):
		var angle = rng.randf_range(0.0, TAU)
		var speed = rng.randf_range(80.0, 210.0)
		var particle_color = base_color.lerp(Color.WHITE, rng.randf_range(0.18, 0.48))
		particle_color.a = 0.88
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(angle) * speed, particle_color, rng.randf_range(3.2, 7.2)))

func _resolve_launcher_target_hit(a: GameBall, b: GameBall, a_index: int, b_index: int, impact_position: Vector2, removed: Dictionary) -> void:
	var launcher_index = a_index if not a.is_target else b_index
	var target_index = b_index if not a.is_target else a_index
	var launcher_ball = a if not a.is_target else b
	var target_ball = b if not a.is_target else a

	_maybe_spawn_perfect(a, b, impact_position)
	if launcher_ball.special_kind == "missile":
		_resolve_missile_impact(launcher_ball, target_ball, launcher_index, target_index, impact_position, removed)
		return
	if launcher_ball.special_kind == "crystal":
		launcher_ball.collision_count += 1
		if _level_has_target_hp():
			_damage_target_ball(target_ball, impact_position)
		else:
			target_ball.hp = 0
		if target_ball.hp <= 0:
			removed[target_index] = true
			_create_explosion(impact_position, target_ball.color_name)
		_crystal_absorb_impact(launcher_ball, launcher_index, removed)
		if not removed.has(launcher_index):
			_separate_surviving_launcher_from_target(launcher_ball, target_ball)
		return

	if _level_has_target_hp():
		_damage_target_ball(target_ball, impact_position)
		if target_ball.hp <= 0:
			removed[launcher_index] = true
			removed[target_index] = true
			_create_explosion(impact_position, target_ball.color_name)
			return
		launcher_ball.collision_count += 1
		if _ball_speed_decays(launcher_ball):
			launcher_ball.speed *= PLAYER_BALL_BOUNCE_RESTITUTION
			if launcher_ball.speed <= PLAYER_BALL_MIN_ALIVE_SPEED:
				launcher_ball.speed = 0.0
		_separate_surviving_launcher_from_target(launcher_ball, target_ball)
		return

	removed[launcher_index] = true
	removed[target_index] = true
	_create_explosion(impact_position, target_ball.color_name)

func _resolve_missile_impact(launcher_ball: GameBall, target_ball: GameBall, launcher_index: int, target_index: int, _impact_position: Vector2, removed: Dictionary) -> void:
	var explosion_position := target_ball.position
	removed[launcher_index] = true
	removed[target_index] = true
	_create_missile_explosion(explosion_position, target_ball.color_name)
	for index in range(balls.size()):
		if index == launcher_index or index == target_index or removed.has(index):
			continue
		var ball = balls[index]
		if not ball.is_target:
			continue
		if ball.position.distance_to(explosion_position) > MISSILE_BLAST_RADIUS + ball.radius:
			continue
		_damage_target_ball(ball, ball.position)
		if ball.hp <= 0:
			removed[index] = true
			_create_explosion(ball.position, ball.color_name)

func _separate_surviving_launcher_from_target(launcher_ball: GameBall, target_ball: GameBall) -> void:
	var delta = launcher_ball.position - target_ball.position
	var normal := Vector2.UP if delta.length_squared() < 0.001 else delta.normalized()
	launcher_ball.position = target_ball.position + normal * (launcher_ball.radius + target_ball.radius + 2.0)
	launcher_ball.velocity = launcher_ball.velocity.bounce(normal)
	_keep_ball_speed(launcher_ball)

func _damage_target_ball(target_ball: GameBall, impact_position: Vector2) -> void:
	target_ball.hp = maxi(target_ball.hp - 1, 0)
	_spawn_hp_change_text("-1", impact_position, Color("#fffefd"))

func _level_has_wall_recolor() -> bool:
	return current_level >= 6

func _level_has_target_hp() -> bool:
	return current_level >= 11

func _wall_color_for_side_y(colors: Array, y: float) -> String:
	if not _level_has_wall_recolor() or colors.is_empty():
		return ""
	var segment_height = arena.size.y / float(colors.size())
	if segment_height <= 0.0:
		return ""
	var index = int(floor((y - arena.position.y) / segment_height))
	index = mini(maxi(index, 0), colors.size() - 1)
	return colors[index]

func _recolor_ball_from_wall(ball: GameBall, color_name: String) -> void:
	if not ball.is_target or color_name == "":
		return
	if _is_mixed_color(ball.color_name):
		return
	if ball.wall_recolor_cooldown > 0.0:
		return
	if _level_has_target_hp() and ball.color_name == color_name:
		_charge_target_from_wall(ball, color_name)
		return
	if ball.color_name == color_name:
		return
	ball.color_name = color_name
	ball.wall_recolor_cooldown = WALL_RECOLOR_COOLDOWN
	_create_recolor_feedback(ball.position, color_name)

func _charge_target_from_wall(ball: GameBall, color_name: String) -> void:
	if ball.hp >= ball.max_hp:
		return
	if ball.wall_charge_count >= TARGET_WALL_CHARGE_MAX:
		return
	ball.hp = mini(ball.hp + 1, ball.max_hp)
	ball.wall_charge_count += 1
	_spawn_hp_change_text("+1", ball.position, COLOR_VALUES[color_name].lerp(Color.WHITE, 0.28))
	_create_recolor_feedback(ball.position, color_name)

func _create_recolor_feedback(position: Vector2, color_name: String) -> void:
	var base_color: Color = COLOR_VALUES[color_name]
	for index in range(8):
		var angle = rng.randf_range(0.0, TAU)
		var speed = rng.randf_range(70.0, 170.0)
		var particle_color = base_color.lerp(Color.WHITE, rng.randf_range(0.12, 0.42))
		particle_color.a = 0.84
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(angle) * speed, particle_color, rng.randf_range(2.2, 5.0)))

func _expire_spent_launcher_balls() -> void:
	if level_complete:
		return

	var expired := false
	var survivors: Array[GameBall] = []
	for ball in balls:
		var spent_by_collision_limit := not ball.is_target and ball.collision_count >= _launcher_collision_limit(ball)
		var spent_by_crystal_hp := not ball.is_target and ball.special_kind == "crystal" and ball.special_hp <= 0
		var spent_by_speed := _ball_speed_decays(ball) and ball.speed <= 0.01
		var spent_by_missile_no_target := not ball.is_target and ball.special_kind == "missile" and _missile_target_for(ball) == null
		if spent_by_collision_limit or spent_by_crystal_hp or spent_by_speed or spent_by_missile_no_target:
			expired = true
			if ball.is_furball:
				_create_furball_smoke(ball.position, ball.radius)
			elif ball.special_kind == "crystal":
				_create_crystal_shatter(ball.position, ball.radius)
				_play_sfx(SFX_GLASS_SHATTER_STREAM)
			else:
				_create_shot_expire_feedback(ball)
			_unlock_tutorial_retry(ball.color_name)
			continue
		survivors.append(ball)

	if expired:
		balls = survivors
		_pulse_prompt(_t("Shot expired - pull again."))
	_check_level_failed()

func _launcher_collision_limit(ball: GameBall) -> int:
	if ball.is_furball:
		return 1 << 30
	if ball.special_kind == "crystal":
		return 1 << 30
	if ball.special_kind == "missile":
		return 1 << 30
	if ball.special_kind == "" and _is_mixed_color(ball.color_name):
		return MIXED_LAUNCHER_COLLISIONS
	return MAX_LAUNCHER_COLLISIONS

const DISCO_COLORS := [
	Color("#ff4d6d"), Color("#ffd24d"), Color("#4dff88"),
	Color("#4db8ff"), Color("#b84dff"), Color("#ff8fc0"),
]

func _any_furball_alive() -> bool:
	for ball in balls:
		if not ball.is_target and ball.is_furball:
			return true
	return false

func _step_furball_lifetimes(delta: float) -> void:
	var exploded := false
	var survivors: Array[GameBall] = []
	for ball in balls:
		if not ball.is_target and ball.is_furball and ball.furball_life >= 0.0:
			ball.furball_life -= delta
			if ball.furball_life <= 0.0:
				exploded = true
				_create_furball_final_burst(ball.position, ball.radius)
				continue
		survivors.append(ball)
	if exploded:
		balls = survivors
		if meow_player != null and meow_player.playing and not _any_furball_alive():
			meow_player.stop()
		_check_level_complete()
		_check_level_failed()

func _create_furball_final_burst(position: Vector2, radius: float) -> void:
	# Pink firework: dense smoke bloom in layered shells + streaking sparks.
	var smoke_palette := [Color("#ff9fc4"), Color("#ffd7e8"), Color("#ff7bb0"), Color("#ffc2f0"), Color("#fff0f7")]
	for index in range(170):
		var angle = rng.randf_range(0.0, TAU)
		var shell := rng.randf()
		var speed = lerpf(12.0, 320.0, shell * shell) * rng.randf_range(0.55, 1.45)
		var puff_color: Color = smoke_palette[rng.randi_range(0, smoke_palette.size() - 1)]
		puff_color = puff_color.lerp(Color.WHITE, rng.randf_range(0.0, 0.35))
		puff_color.a = rng.randf_range(0.55, 0.9)
		var puff_offset := Vector2.RIGHT.rotated(rng.randf_range(0.0, TAU)) * rng.randf_range(0.0, radius * 0.9)
		particles.append(BurstParticle.new(position + puff_offset, Vector2.RIGHT.rotated(angle) * speed, puff_color, rng.randf_range(1.6, 9.0), "puff", rng.randf_range(2.4, 4.2)))
	for index in range(30):
		var spark_angle = rng.randf_range(0.0, TAU)
		var spark_speed = rng.randf_range(150.0, 720.0)
		var spark_color := Color("#ff7bb0").lerp(Color("#fff3fa"), rng.randf_range(0.0, 0.8))
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(spark_angle) * spark_speed, spark_color, rng.randf_range(1.2, 4.2), "spark", rng.randf_range(0.4, 1.0)))
	particles.append(BurstParticle.new(position, Vector2.ZERO, Color(1.0, 0.78, 0.90, 0.95), radius * 4.5, "flash", 0.20))
	particles.append(BurstParticle.new(position, Vector2.ZERO, Color(1.0, 0.92, 0.97, 0.75), radius * 7.0, "flash", 0.30))
	_play_sfx(SFX_FURBALL_POP_STREAM)

func _draw_disco_lights() -> void:
	if not _any_furball_alive() or arena.size.x <= 0.0:
		return
	var center := arena.get_center()
	var spin := effects_anim_time * 1.9
	var strobe := 0.5 + 0.5 * sin(effects_anim_time * 9.0)
	for index in range(DISCO_COLORS.size()):
		var phase := spin + TAU * float(index) / float(DISCO_COLORS.size())
		var orbit_x := cos(phase) * arena.size.x * 0.38
		var orbit_y := sin(phase * 1.31 + float(index)) * arena.size.y * 0.36
		var spot_center := center + Vector2(orbit_x, orbit_y)
		var spot_radius: float = arena.size.x * (0.30 + 0.08 * sin(effects_anim_time * 3.7 + float(index) * 2.1))
		var spot_color: Color = DISCO_COLORS[index]
		spot_color.a = 0.22 + 0.16 * strobe
		var spot_rect := Rect2(spot_center - Vector2(spot_radius, spot_radius), Vector2(spot_radius, spot_radius) * 2.0)
		draw_texture_rect(_glow_texture(), spot_rect, false, spot_color)
	var wash: Color = DISCO_COLORS[int(effects_anim_time * 4.0) % DISCO_COLORS.size()]
	wash.a = 0.07 + 0.07 * strobe
	draw_rect(arena, wash, true)

func _draw_missile_locks() -> void:
	for ball in balls:
		if ball.is_target or ball.special_kind != "missile":
			continue
		var target = _missile_target_for(ball)
		if target == null:
			continue
		var blink := fposmod(effects_anim_time * 2.6, 1.0) < 0.55
		var bracket_color := Color(1.0, 1.0, 1.0, 1.0 if blink else 0.35)
		var half: float = target.radius * 1.45
		var arm: float = half * 0.55
		var line_width := maxf(2.0, target.radius * 0.13)
		for sx in [-1.0, 1.0]:
			for sy in [-1.0, 1.0]:
				var corner: Vector2 = target.position + Vector2(half * sx, half * sy)
				draw_line(corner, corner + Vector2(-arm * sx, 0.0), bracket_color, line_width, true)
				draw_line(corner, corner + Vector2(0.0, -arm * sy), bracket_color, line_width, true)
		var font_size := int(maxf(10.0, target.radius * 0.5))
		var text_y: float = target.position.y + font_size * 0.36
		var text_alpha := 1.0 if blink else 0.4
		draw_string_outline(PIXEL_FONT, Vector2(target.position.x - half, text_y), "LOCKED", HORIZONTAL_ALIGNMENT_CENTER, half * 2.0, font_size, int(maxf(2.0, font_size * 0.18)), Color(0.05, 0.05, 0.05, text_alpha))
		draw_string(PIXEL_FONT, Vector2(target.position.x - half, text_y), "LOCKED", HORIZONTAL_ALIGNMENT_CENTER, half * 2.0, font_size, Color(1.0, 1.0, 1.0, text_alpha))

func _create_full_charge_muzzle(position: Vector2, direction: Vector2, color_name: String) -> void:
	var base_color: Color = COLOR_VALUES.get(color_name, Color.WHITE)
	for index in range(16):
		var spread := rng.randf_range(-0.55, 0.55)
		var spark_dir := direction.rotated(spread)
		var spark_speed := rng.randf_range(260.0, 620.0)
		var spark_color := base_color.lerp(Color.WHITE, rng.randf_range(0.25, 0.7))
		particles.append(BurstParticle.new(position + spark_dir * LAUNCH_RADIUS, spark_dir * spark_speed, spark_color, rng.randf_range(1.8, 3.4), "spark", rng.randf_range(0.25, 0.45)))
	particles.append(BurstParticle.new(position, Vector2.ZERO, Color(base_color.lightened(0.4), 0.9), LAUNCH_RADIUS * 3.0, "flash", 0.14))

func _emit_burst_trail(ball: GameBall) -> void:
	if particles.size() > 260 or ball.velocity.length_squared() < 0.001:
		return
	var direction := (ball.velocity as Vector2).normalized()
	var side := Vector2(-direction.y, direction.x)
	var base_color: Color = COLOR_VALUES.get(ball.color_name, Color.WHITE)
	for index in range(2):
		var tail_position: Vector2 = ball.position - direction * ball.radius * (1.1 + rng.randf_range(0.0, 0.5)) + side * rng.randf_range(-4.0, 4.0)
		var tail_velocity: Vector2 = -direction * rng.randf_range(60.0, 160.0) + side * rng.randf_range(-30.0, 30.0)
		var tail_color := base_color.lerp(Color.WHITE, rng.randf_range(0.2, 0.6))
		tail_color.a = 0.8
		particles.append(BurstParticle.new(tail_position, tail_velocity, tail_color, rng.randf_range(1.8, 3.6), "spark", 0.28))

func _create_crystal_shatter(position: Vector2, radius: float) -> void:
	for index in range(30):
		var angle = rng.randf_range(0.0, TAU)
		var speed = rng.randf_range(160.0, 420.0)
		var shard_color := Color("#eafcff").lerp(Color("#9fdcf0"), rng.randf_range(0.0, 0.85))
		shard_color.a = 0.92
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(angle) * speed, shard_color, rng.randf_range(1.6, 3.4), "spark", rng.randf_range(0.30, 0.55)))
	for index in range(10):
		var glint_angle = rng.randf_range(0.0, TAU)
		var glint_speed = rng.randf_range(60.0, 150.0)
		var glint_color := Color(1.0, 1.0, 1.0, 0.85)
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(glint_angle) * glint_speed, glint_color, rng.randf_range(2.4, 4.6), "puff", rng.randf_range(0.35, 0.6)))
	particles.append(BurstParticle.new(position, Vector2.ZERO, Color(0.92, 0.99, 1.0, 0.95), radius * 3.0, "flash", 0.14))

func _create_furball_smoke(position: Vector2, radius: float) -> void:
	for index in range(26):
		var angle = rng.randf_range(0.0, TAU)
		var speed = rng.randf_range(40.0, 170.0)
		var puff_color := Color("#ff9fc4").lerp(Color("#ffd7e8"), rng.randf_range(0.0, 0.8))
		puff_color.a = 0.85
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(angle) * speed, puff_color, rng.randf_range(4.0, 9.5), "puff", rng.randf_range(0.55, 0.95)))
	for index in range(8):
		var spark_angle = rng.randf_range(0.0, TAU)
		var spark_speed = rng.randf_range(240.0, 480.0)
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(spark_angle) * spark_speed, Color("#ff7bb0"), rng.randf_range(1.4, 2.4), "spark", 0.4))
	particles.append(BurstParticle.new(position, Vector2.ZERO, Color(1.0, 0.72, 0.86, 0.9), radius * 3.2, "flash", 0.16))

func _create_shot_expire_feedback(ball: GameBall) -> void:
	var base_color: Color = COLOR_VALUES[ball.color_name]
	for index in range(12):
		var angle = rng.randf_range(0.0, TAU)
		var speed = rng.randf_range(55.0, 150.0)
		var particle_color = base_color.lerp(Color.WHITE, 0.54)
		particle_color.a = 0.74
		particles.append(BurstParticle.new(ball.position, Vector2.RIGHT.rotated(angle) * speed, particle_color, rng.randf_range(2.0, 4.6)))

func _unlock_tutorial_retry(color_name: String) -> void:
	if current_level != 1:
		return
	if _target_count_for_color(color_name) <= 0:
		return

	shots_fired[color_name] = false
	_refresh_tutorial_step()

func _refresh_tutorial_step() -> void:
	# Next color the tutorial asks for = first one never launched this level.
	# Based on tutorial_colors_fired (not shots_fired) so a missed shot never
	# regresses the step and re-locks later colors.
	for index in range(COLOR_ORDER.size()):
		var color_name: String = COLOR_ORDER[index]
		if _target_count_for_color(color_name) > 0 and not tutorial_colors_fired.get(color_name, false):
			tutorial_step = index
			return
	tutorial_step = COLOR_ORDER.size()

func _can_pop_pair(a: GameBall, b: GameBall) -> bool:
	if a.is_target == b.is_target:
		return false
	var launcher_ball := a if not a.is_target else b
	var target_ball := b if not a.is_target else a
	if launcher_ball.special_kind == "missile":
		return launcher_ball.color_name == target_ball.color_name
	if launcher_ball.special_kind == "crystal":
		return true
	if launcher_ball.special_kind != "":
		return false
	return launcher_ball.color_name == target_ball.color_name

func _maybe_spawn_perfect(a: GameBall, b: GameBall, impact_position: Vector2) -> void:
	var launcher_ball := a if not a.is_target else b
	var target_ball := b if not a.is_target else a
	if launcher_ball.collision_count == 0:
		level_perfect_hits += 1
		_spawn_perfect_text(impact_position, target_ball.color_name)

func _spawn_perfect_text(position: Vector2, color_name: String) -> void:
	var label := Label.new()
	label.text = _random_perfect_praise_text()
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_override("font", PIXEL_FONT)
	label.add_theme_font_size_override("font_size", 46)
	var perfect_color: Color = COLOR_VALUES.get(color_name, Color("#ffd83d"))
	label.add_theme_color_override("font_color", perfect_color.lightened(0.12))
	label.add_theme_color_override("font_outline_color", perfect_color.darkened(0.62))
	label.add_theme_constant_override("outline_size", 7)
	label.size = Vector2(380.0, 80.0)
	label.pivot_offset = label.size * 0.5
	label.position = position - label.size * 0.5 - Vector2(0.0, 30.0)
	label.position.x = clampf(label.position.x, 8.0, get_viewport_rect().size.x - label.size.x - 8.0)
	label.scale = Vector2(0.72, 0.72)
	add_child(label)
	floating_texts.append(FloatingText.new(label, Vector2.ZERO, true, 1.3))
	_play_praise_voice(label.text)

func _play_praise_voice(praise_text: String) -> void:
	if voice_player == null:
		return
	var stream: AudioStream = PRAISE_VOICE_STREAMS.get(praise_text)
	if stream == null:
		return
	voice_player.stream = stream
	voice_player.play()

func _random_perfect_praise_text() -> String:
	var texts := PERFECT_PRAISE_TEXTS
	if settings_language == "zh":
		texts = PERFECT_PRAISE_TEXTS_ZH
	elif settings_language == "zh_hant":
		texts = PERFECT_PRAISE_TEXTS_ZH_HANT
	return String(texts[rng.randi_range(0, texts.size() - 1)])

func _spawn_hp_change_text(text: String, position: Vector2, color: Color) -> void:
	var label := Label.new()
	label.text = text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_override("font", PIXEL_FONT)
	label.add_theme_font_size_override("font_size", 22)
	label.add_theme_color_override("font_color", color)
	label.add_theme_color_override("font_outline_color", Color("#171717"))
	label.add_theme_constant_override("outline_size", 4)
	label.size = Vector2(76.0, 34.0)
	label.position = position - Vector2(label.size.x * 0.5, 26.0)
	add_child(label)
	floating_texts.append(FloatingText.new(label, Vector2(0.0, -42.0)))

func _bounce_different_colors(a: GameBall, b: GameBall, delta: Vector2, distance: float, min_distance: float) -> void:
	var normal := Vector2.RIGHT if distance < 0.001 else delta / distance
	var overlap = maxf(min_distance - distance, 0.0)
	a.position -= normal * overlap * 0.5
	b.position += normal * overlap * 0.5

	var projected_speed = a.velocity.dot(normal) - b.velocity.dot(normal)
	if projected_speed <= 0.0:
		return

	if _should_play_ball_collision_sound(a, b):
		_play_collision_sound(_ball_collision_intensity(a, b))
	if not a.is_target:
		_register_launcher_collision(a)
	if not b.is_target:
		_register_launcher_collision(b)
	if _ball_speed_decays(a):
		a.speed *= PLAYER_BALL_BOUNCE_RESTITUTION
		if a.speed <= PLAYER_BALL_MIN_ALIVE_SPEED:
			a.speed = 0.0
	if _ball_speed_decays(b):
		b.speed *= PLAYER_BALL_BOUNCE_RESTITUTION
		if b.speed <= PLAYER_BALL_MIN_ALIVE_SPEED:
			b.speed = 0.0

	if a.is_target:
		a.velocity -= normal * projected_speed
	else:
		var a_dot := a.velocity.dot(normal)
		if a_dot > 0.0:
			a.velocity -= normal * (2.0 * a_dot)
	if b.is_target:
		b.velocity += normal * projected_speed
	else:
		var b_dot := b.velocity.dot(normal)
		if b_dot < 0.0:
			b.velocity -= normal * (2.0 * b_dot)
	var tangential := (a.velocity - b.velocity).cross(normal)
	a.spin_velocity = -tangential / maxf(a.radius, 1.0) * 0.35
	b.spin_velocity = tangential / maxf(b.radius, 1.0) * 0.35
	_keep_ball_speed(a)
	_keep_ball_speed(b)

func _register_launcher_collision(ball: GameBall) -> void:
	ball.collision_count += 1
	if ball.special_kind == "crystal":
		ball.special_hp -= 1

func _update_charging_audio() -> void:
	if charging_player == null:
		return
	var charged := drag_active and drag_color != "" and _launch_tension() >= 0.999
	if charged and not charging_player.playing:
		charging_player.play()
	elif not charged and charging_player.playing:
		charging_player.stop()

func _ball_speed_decays(ball: GameBall) -> bool:
	return not ball.is_target and ball.special_kind == "" and not ball.is_furball

func _keep_ball_speed(ball: GameBall) -> void:
	if ball.velocity.length_squared() < 0.001:
		ball.velocity = Vector2.UP.rotated(rng.randf_range(-0.7, 0.7)) * ball.speed
	else:
		ball.velocity = ball.velocity.normalized() * ball.speed

func _step_particles(delta: float) -> void:
	for index in range(particles.size() - 1, -1, -1):
		var particle = particles[index]
		particle.life -= delta
		if particle.life <= 0.0:
			particles.remove_at(index)
			continue
		particle.position += particle.velocity * delta
		if particle.kind == "spark":
			particle.velocity *= 0.90
			particle.velocity.y += 1250.0 * delta
		elif particle.kind == "ember":
			particle.velocity *= 0.96
			particle.velocity.y += 620.0 * delta
		else:
			particle.velocity *= 0.94

func _step_floating_texts(delta: float) -> void:
	for index in range(floating_texts.size() - 1, -1, -1):
		var floating_text = floating_texts[index]
		floating_text.life -= delta
		if floating_text.label != null and is_instance_valid(floating_text.label):
			if floating_text.popup:
				var elapsed: float = floating_text.max_life - floating_text.life
				var pop_in: float = clampf(elapsed / 0.16, 0.0, 1.0)
				var settle: float = clampf((elapsed - 0.16) / 0.20, 0.0, 1.0)
				var scale_value: float = lerpf(0.72, 1.16, pop_in)
				if settle > 0.0:
					scale_value = lerpf(scale_value, 1.0, settle)
				floating_text.label.scale = Vector2(scale_value, scale_value)
			else:
				floating_text.label.position += floating_text.velocity * delta
			floating_text.label.modulate.a = clampf(floating_text.life / floating_text.max_life, 0.0, 1.0)
		if floating_text.life <= 0.0:
			if floating_text.label != null and is_instance_valid(floating_text.label):
				floating_text.label.queue_free()
			floating_texts.remove_at(index)

func _clear_floating_texts() -> void:
	for floating_text in floating_texts:
		if floating_text.label != null and is_instance_valid(floating_text.label):
			floating_text.label.queue_free()
	floating_texts.clear()

func _create_explosion(position: Vector2, color_name: String) -> void:
	var base_color: Color = COLOR_VALUES[color_name]
	_play_explosion_sound(color_name)

	for index in range(PARTICLE_COUNT):
		var angle = rng.randf_range(0.0, TAU)
		var speed = rng.randf_range(110.0, 360.0)
		var particle_color = base_color.lerp(Color.WHITE, rng.randf_range(0.0, 0.38))
		var particle_radius = rng.randf_range(3.0, 7.0)
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(angle) * speed, particle_color, particle_radius))
	for index in range(22):
		var spark_angle = rng.randf_range(0.0, TAU)
		var spark_speed = rng.randf_range(320.0, 760.0)
		var spark_color = base_color.lerp(Color("#fff6cc"), rng.randf_range(0.35, 0.85))
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(spark_angle) * spark_speed, spark_color, rng.randf_range(1.4, 2.6), "spark", rng.randf_range(0.32, 0.55)))
	for index in range(12):
		var ember_angle = rng.randf_range(0.0, TAU)
		var ember_speed = rng.randf_range(90.0, 300.0)
		var ember_color = Color("#ffb23b").lerp(base_color, rng.randf_range(0.0, 0.55))
		var ember_velocity = Vector2.RIGHT.rotated(ember_angle) * ember_speed - Vector2(0.0, rng.randf_range(40.0, 160.0))
		particles.append(BurstParticle.new(position, ember_velocity, ember_color, rng.randf_range(1.6, 3.2), "ember", rng.randf_range(0.45, 0.75)))
	particles.append(BurstParticle.new(position, Vector2.ZERO, Color(1.0, 0.98, 0.88, 0.95), 62.0, "flash", 0.13))
	particles.append(BurstParticle.new(position, Vector2.ZERO, Color(1.0, 1.0, 1.0, 0.9), 46.0, "ring", 0.28))

func _create_missile_explosion(position: Vector2, color_name: String) -> void:
	_play_sfx(SFX_MISSILE_EXPLOSION_STREAM)
	_create_explosion(position, color_name)
	_spawn_hp_change_text("BOOM", position, Color("#ffae3d"))
	for index in range(36):
		var angle = rng.randf_range(0.0, TAU)
		var speed = rng.randf_range(140.0, 560.0)
		var particle_color = Color("#ff8f2a").lerp(Color.WHITE, rng.randf_range(0.0, 0.45))
		particle_color.a = rng.randf_range(0.75, 0.95)
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(angle) * speed, particle_color, rng.randf_range(4.0, 12.0), "puff", rng.randf_range(0.5, 1.1)))
	for index in range(18):
		var ember_angle = rng.randf_range(0.0, TAU)
		var ember_speed = rng.randf_range(180.0, 520.0)
		var ember_color := Color("#ffd27a").lerp(Color("#ff5a1f"), rng.randf_range(0.0, 1.0))
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(ember_angle) * ember_speed, ember_color, rng.randf_range(2.2, 4.6), "ember", rng.randf_range(0.7, 1.3)))
	for index in range(24):
		var spark_angle = rng.randf_range(0.0, TAU)
		var spark_speed = rng.randf_range(320.0, 820.0)
		particles.append(BurstParticle.new(position, Vector2.RIGHT.rotated(spark_angle) * spark_speed, Color("#fff1c9"), rng.randf_range(1.4, 3.0), "spark", rng.randf_range(0.3, 0.6)))
	particles.append(BurstParticle.new(position, Vector2.ZERO, Color(1.0, 0.85, 0.55, 0.95), MISSILE_BLAST_RADIUS * 0.55, "flash", 0.16))
	particles.append(BurstParticle.new(position, Vector2.ZERO, Color(1.0, 0.65, 0.30, 0.55), MISSILE_BLAST_RADIUS * 1.0, "flash", 0.30))

func _play_explosion_sound(color_name: String) -> void:
	var playback = audio_player.get_stream_playback() as AudioStreamGeneratorPlayback
	if playback == null:
		return

	var frequency := 220.0
	if color_name == "yellow":
		frequency = 330.0
	elif color_name == "blue":
		frequency = 440.0
	elif color_name == "orange":
		frequency = 294.0
	elif color_name == "green":
		frequency = 392.0
	elif color_name == "purple":
		frequency = 494.0

	# bubble-pop: sharp noise snap + downward pitch chirp, louder than the old tone
	var pop_frequency := frequency * 2.9
	var frames = mini(int(AUDIO_MIX_RATE * 0.16), playback.get_frames_available())
	var chirp_phase := 0.0
	for frame in range(frames):
		var t = float(frame) / float(AUDIO_MIX_RATE)
		var chirp_frequency = pop_frequency * exp(-t * 13.0) + 110.0
		chirp_phase += TAU * chirp_frequency / float(AUDIO_MIX_RATE)
		var body = sin(chirp_phase) * exp(-t * 24.0) * 0.78
		var snap = rng.randf_range(-1.0, 1.0) * exp(-t * 140.0) * 0.6
		var sample = clampf(body + snap, -1.0, 1.0) * 0.92
		playback.push_frame(Vector2(sample, sample))

func _should_play_ball_collision_sound(_a: GameBall, _b: GameBall) -> bool:
	return true

func _ball_collision_intensity(a: GameBall, b: GameBall) -> float:
	var relative_speed = (a.velocity - b.velocity).length()
	return clampf(relative_speed / (LAUNCH_MAX_SPEED * 1.25), 0.32, 1.0)

func _play_coin_chime(step: int) -> void:
	if audio_player == null:
		return
	var playback = audio_player.get_stream_playback() as AudioStreamGeneratorPlayback
	if playback == null:
		return
	var frames = mini(int(AUDIO_MIX_RATE * COIN_CHIME_DURATION), playback.get_frames_available())
	if frames <= 64:
		return
	var pitch_step := float(step % 9)
	var frequency := 880.0 * pow(2.0, pitch_step / 12.0)
	for frame in range(frames):
		var t = float(frame) / float(AUDIO_MIX_RATE)
		var progress = clampf(t / COIN_CHIME_DURATION, 0.0, 1.0)
		var envelope = pow(1.0 - progress, 1.8)
		var tone = sin(TAU * frequency * t) * 0.82 + sin(TAU * frequency * 2.0 * t) * 0.18
		var sample = tone * envelope * 0.18
		playback.push_frame(Vector2(sample, sample))

func _play_collision_sound(intensity: float) -> void:
	if collision_audio_player == null or collision_sound_timer > 0.0:
		return
	var playback = collision_audio_player.get_stream_playback() as AudioStreamGeneratorPlayback
	if playback == null:
		return
	var frames = mini(int(AUDIO_MIX_RATE * COLLISION_SOUND_DURATION), playback.get_frames_available())
	if frames <= 256:
		return
	collision_sound_timer = COLLISION_SOUND_MIN_INTERVAL
	var strength = clampf(intensity, 0.0, 1.0)
	var knock_frequency = rng.randf_range(820.0, 980.0)
	var knock_overtone = knock_frequency * rng.randf_range(1.85, 2.05)
	var ping_frequency = rng.randf_range(3100.0, 3700.0)
	var volume = lerpf(0.24, 0.46, strength)
	for frame in range(frames):
		var t = float(frame) / float(AUDIO_MIX_RATE)
		var snap = rng.randf_range(-1.0, 1.0) * exp(-t * 420.0) * 0.9
		var knock = sin(TAU * knock_frequency * t) * exp(-t * 62.0) * 0.85
		knock += sin(TAU * knock_overtone * t) * exp(-t * 95.0) * 0.45
		var ping = sin(TAU * ping_frequency * t) * exp(-t * 130.0) * 0.30
		var sample = clampf((snap + knock + ping) * volume, -1.0, 1.0)
		playback.push_frame(Vector2(sample, sample))

func _base_shot_limit_for_level(level: int) -> int:
	var index := clampi(level, 1, LEVEL_SHOT_LIMITS.size()) - 1
	return int(LEVEL_SHOT_LIMITS[index]) + SHOT_LIMIT_BONUS

func _shots_remaining() -> int:
	return maxi(shot_limit - shots_used, 0)

func _extra_shot_cost() -> int:
	return EXTRA_SHOT_BASE_COST + current_level * EXTRA_SHOT_LEVEL_COST + extra_shot_purchases * EXTRA_SHOT_REPEAT_COST

func _has_active_launcher_balls() -> bool:
	for ball in balls:
		if not ball.is_target:
			return true
	return false

func _check_level_failed() -> void:
	if level_complete or level_failed:
		return
	if _remaining_target_count() <= 0:
		return
	if shots_used < shot_limit:
		return
	if _has_active_launcher_balls():
		return
	level_failed = true
	_clear_drag()
	_layout_level_failed_dialog()
	_play_warning_sound()

func _handle_failed_level_press() -> void:
	var cost := _extra_shot_cost()
	if coin_count >= cost:
		coin_count -= cost
		shot_limit += EXTRA_SHOTS_PER_BUY
		extra_shot_purchases += 1
		level_failed = false
		_layout_level_failed_dialog()
		_save_progress(current_level)
		_position_prompt_label(false)
		_pulse_prompt(_t("+%d shots bought.") % EXTRA_SHOTS_PER_BUY)
		return
	_start_level()

func _check_level_complete() -> void:
	if level_complete or level_complete_pending:
		return
	if _remaining_target_count() > 0:
		return
	if _any_furball_alive():
		return
	level_complete_pending = true
	level_complete_delay_timer = LEVEL_COMPLETE_DELAY_SECONDS

func _finalize_level_complete() -> void:
	level_complete_pending = false
	if level_complete:
		return
	_clear_remaining_launcher_balls()
	level_complete = true
	_clear_drag()
	_position_prompt_label(false)
	_award_level_coins()
	_start_level_complete_panel()
	if victory_player != null:
		victory_fade_timer = 0.0
		victory_player.volume_db = _settings_base_db() + MUSIC_BASE_DB_OFFSET
		victory_player.play()
	if music_player != null:
		music_player.stop()
	var next_saved_level := current_level + 1 if current_level < LEVEL_TARGET_COUNTS.size() else 1
	_save_progress(next_saved_level)
	prompt_label.text = ""

func _clear_remaining_launcher_balls() -> void:
	var survivors: Array[GameBall] = []
	for ball in balls:
		if ball.is_target:
			survivors.append(ball)
			continue
		_create_explosion(ball.position, ball.color_name)
	balls = survivors

func _remaining_target_count() -> int:
	var count := 0
	for ball in balls:
		if ball.is_target:
			count += 1
	return count

func _enforce_launcher_color_caps() -> void:
	var launcher_counts := {}
	var pending_mix_batches := {}
	var rejected_mix_batches := {}
	var survivors: Array[GameBall] = []
	for ball in balls:
		if ball.is_target or ball.special_kind != "" or ball.is_furball or ball.swallow_timer >= 0.0:
			survivors.append(ball)
			continue
		if ball.mix_batch_id > 0 and ball.mix_result_special_kind != "":
			survivors.append(ball)
			continue

		if ball.mix_batch_id > 0:
			if rejected_mix_batches.has(ball.mix_batch_id):
				_create_explosion(ball.position, ball.color_name)
				continue
			if pending_mix_batches.has(ball.mix_batch_id):
				survivors.append(ball)
				continue
			var mixed_color := ball.mix_result_color
			var mixed_count = int(launcher_counts.get(mixed_color, 0))
			var mixed_allowed := _allowed_launcher_count_for_color(mixed_color)
			if mixed_color == "" or mixed_count >= mixed_allowed:
				rejected_mix_batches[ball.mix_batch_id] = true
				_create_explosion(ball.position, ball.color_name)
				continue
			pending_mix_batches[ball.mix_batch_id] = true
			launcher_counts[mixed_color] = mixed_count + 1
			survivors.append(ball)
			continue

		var color_count = int(launcher_counts.get(ball.color_name, 0))
		var allowed_count := _allowed_launcher_count_for_color(ball.color_name)
		if color_count >= allowed_count:
			_create_explosion(ball.position, ball.color_name)
			continue

		launcher_counts[ball.color_name] = color_count + 1
		survivors.append(ball)
	balls = survivors

func _allowed_launcher_count_for_color(color_name: String) -> int:
	var target_count := _target_count_for_color(color_name)
	if target_count > 0:
		return target_count
	if _level_has_color_mixing() and _is_primary_color(color_name):
		return 0
	if _level_has_wall_recolor() and _remaining_target_count() > 0:
		return 1
	return 0

func _launcher_count_for_color(color_name: String) -> int:
	var count := 0
	for ball in balls:
		if not ball.is_target and ball.special_kind == "" and ball.mix_batch_id <= 0 and ball.color_name == color_name:
			count += 1
	return count

func _launcher_commitment_count_for_color(color_name: String) -> int:
	var count := _launcher_count_for_color(color_name)
	var pending_batches := {}
	for ball in balls:
		if ball.is_target or ball.special_kind != "" or ball.mix_batch_id <= 0:
			continue
		if ball.mix_result_color == color_name:
			pending_batches[ball.mix_batch_id] = true
	return count + pending_batches.size()

func _target_count_for_color(color_name: String) -> int:
	var count := 0
	for ball in balls:
		if ball.is_target and ball.color_name == color_name:
			count += 1
	return count

func _update_prompt() -> void:
	hud_label.text = ""
	if coin_label != null:
		coin_label.text = ""
	if level_intro_active:
		_position_prompt_label(false)
		prompt_label.text = ""
		return
	if level_complete:
		_position_prompt_label(false)
		prompt_label.text = ""
		return
	if level_failed:
		_position_prompt_label(false)
		prompt_label.text = ""
		return
	_position_prompt_label(false)
	prompt_at_launcher = false
	if invalid_prompt_timer > 0.0:
		prompt_label.text = invalid_prompt_text
		return

	if drag_active:
		prompt_at_launcher = true
		if drag_mix_locked:
			var power_locked = int(round(_launch_tension() * 100.0))
			if armed_special_kind != "":
				prompt_label.text = _t("Release %s %s") % [_special_word(armed_special_kind), _color_word(drag_mix_result_color)]
			else:
				prompt_label.text = _t("Release %s  |  Power %d%%") % [_color_word(drag_mix_result_color), power_locked]
		else:
			var power = int(round(_launch_tension() * 100.0))
			if armed_special_kind != "":
				prompt_label.text = _t("Release %s  |  Power %d%%") % [_special_word(armed_special_kind), power]
			else:
				prompt_label.text = _t("Release to fire  |  Power %d%%") % power
	elif not mix_touch_drags.is_empty():
		prompt_label.text = _mix_drag_prompt()
	elif _shots_remaining() <= 0:
		prompt_label.text = _t("No shots left - watch the board")
	elif armed_special_kind != "":
		prompt_label.text = _t("Pull a color to fire %s") % _special_word(armed_special_kind)
	elif black_hole_respawn_cooldown > 0.0:
		prompt_label.text = _t("Black hole returns in %ds") % ceili(black_hole_respawn_cooldown)
	else:
		prompt_label.text = ""

func _mix_drag_prompt() -> String:
	if mix_touch_drags.size() < 2:
		if armed_special_kind != "":
			return _t("Release for single %s, or hold two colors.") % _special_word(armed_special_kind)
		return _t("Hold two colors to mix.")
	return _t("Release both colors together.")

func _pulse_prompt(text: String) -> void:
	invalid_prompt_text = text
	invalid_prompt_timer = 0.8

func _award_level_coins() -> void:
	last_level_base_reward = _level_base_coin_reward(current_level)
	last_level_perfect_bonus = _level_perfect_coin_bonus(last_level_base_reward, level_perfect_hits)
	last_level_remaining_shots = _shots_remaining()
	last_level_shot_bonus = _level_remaining_shot_bonus(last_level_base_reward, last_level_remaining_shots)
	last_level_reward = last_level_base_reward + last_level_perfect_bonus + last_level_shot_bonus
	last_level_coin_start = coin_count
	coin_count = maxi(coin_count + last_level_reward, 0)

func _level_base_coin_reward(level: int) -> int:
	return COIN_BASE_REWARD + level * COIN_LEVEL_STEP

func _level_perfect_coin_bonus(base_reward: int, perfect_hits: int) -> int:
	var raw_bonus := int(round(float(base_reward) * PERFECT_BONUS_RATE * float(perfect_hits)))
	var cap := int(round(float(base_reward) * PERFECT_BONUS_CAP_RATE))
	return mini(raw_bonus, cap)

func _level_remaining_shot_bonus(base_reward: int, remaining_shots: int) -> int:
	var raw_bonus := int(round(float(base_reward) * REMAINING_SHOT_BONUS_RATE * float(maxi(remaining_shots, 0))))
	var cap := int(round(float(base_reward) * REMAINING_SHOT_BONUS_CAP_RATE))
	return mini(raw_bonus, cap)

func _level_complete_prompt() -> String:
	var action := "next" if current_level < LEVEL_TARGET_COUNTS.size() else "replay"
	return "+%d coins  P:%d  tap %s" % [last_level_reward, level_perfect_hits, action]

func _level_complete_action_text() -> String:
	return _t("TAP FOR NEXT") if current_level < LEVEL_TARGET_COUNTS.size() else _t("TAP TO CONTINUE")

func _animated_level_complete_count(target: int, start_time: float, duration: float, eased := false) -> int:
	if target <= 0:
		return 0
	var elapsed := level_complete_anim_time - start_time
	if elapsed <= 0.0:
		return 0
	var progress := clampf(elapsed / maxf(duration, 0.001), 0.0, 1.0)
	if eased:
		progress = 1.0 - pow(1.0 - progress, 3.0)
	return mini(target, maxi(0, int(ceil(float(target) * progress - 0.001))))

func _displayed_level_complete_perfect_hits() -> int:
	return _animated_level_complete_count(level_perfect_hits, COMPLETE_PERFECT_COUNT_DELAY, COMPLETE_PERFECT_COUNT_SECONDS)

func _displayed_level_complete_remaining_shots() -> int:
	return _animated_level_complete_count(last_level_remaining_shots, COMPLETE_SHOT_COUNT_DELAY, COMPLETE_SHOT_COUNT_SECONDS)

func _displayed_level_complete_coin_reward() -> int:
	return _animated_level_complete_count(last_level_reward, COMPLETE_COIN_COUNT_DELAY, COMPLETE_COIN_COUNT_SECONDS, true)

func _displayed_level_complete_coin_total() -> int:
	return last_level_coin_start + _displayed_level_complete_coin_reward()

func _step_level_complete_panel(delta: float) -> void:
	level_complete_anim_time += delta
	var displayed_coin_reward := _displayed_level_complete_coin_reward()
	if displayed_coin_reward > level_complete_last_displayed_coin_reward:
		if level_complete_anim_time - level_complete_last_coin_chime_time >= COIN_CHIME_MIN_INTERVAL:
			_play_coin_chime(displayed_coin_reward)
			level_complete_last_coin_chime_time = level_complete_anim_time
		level_complete_last_displayed_coin_reward = displayed_coin_reward

func _handle_powerup_press(position: Vector2) -> bool:
	var powerup_id := _powerup_at(position)
	if powerup_id == "":
		return false
	return _handle_powerup_tap(powerup_id, position)

func _handle_powerup_tap(powerup_id: String, position: Vector2) -> bool:
	if _is_powerup_input_locked():
		return true
	if _is_duplicate_powerup_press(powerup_id, position):
		return true
	if armed_special_kind != "":
		if powerup_id == armed_special_kind:
			_remember_powerup_press(powerup_id, position)
			_register_ui_press("powerup_%s" % powerup_id, false)
			_cancel_armed_special()
		return true
	_remember_powerup_press(powerup_id, position)
	_register_ui_press("powerup_%s" % powerup_id, false)
	var help_id := _powerup_help_id_for_powerup(powerup_id)
	if help_id != "" and not bool(powerup_help_seen.get(help_id, false)):
		_show_powerup_help(help_id, powerup_id)
		return true
	if _powerup_needs_confirm(powerup_id):
		_show_powerup_confirm(powerup_id)
		return true
	_activate_powerup_by_id(powerup_id)
	return true

func _powerup_needs_confirm(powerup_id: String) -> bool:
	if powerup_id == "furball":
		return not furball_shot_armed and not _any_furball_alive()
	return powerup_id == "freeze" or powerup_id.begins_with("bomb_")

func _powerup_cost_for_id(powerup_id: String) -> int:
	if powerup_id == "aimer":
		return AIMER_COST
	if powerup_id == "freeze":
		return FREEZE_COST
	if powerup_id.begins_with("bomb_"):
		return COLOR_BOMB_COST
	if powerup_id == "crystal":
		return CRYSTAL_BALL_COST
	if powerup_id == "antimatter":
		return ANTIMATTER_BALL_COST
	if powerup_id == "missile":
		return MISSILE_COST
	if powerup_id == "furball":
		return PINK_FURBALL_COST
	return 0

func _cancel_armed_special() -> void:
	var special_kind := armed_special_kind
	var refund := _powerup_cost_for_id(special_kind)
	armed_special_kind = ""
	coin_count += refund
	_save_progress(current_level)
	_pulse_prompt(_t("%s cancelled - $%d back.") % [_special_word(special_kind), refund])
	queue_redraw()

func _show_powerup_confirm(powerup_id: String) -> void:
	powerup_confirm_active = true
	powerup_confirm_id = powerup_id
	_layout_powerup_confirm_dialog()
	queue_redraw()

func _clear_powerup_confirm() -> void:
	powerup_confirm_active = false
	powerup_confirm_id = ""
	powerup_confirm_dialog_rect = Rect2()
	powerup_confirm_ok_rect = Rect2()

func _powerup_confirm_title(powerup_id: String) -> String:
	if powerup_id == "freeze":
		return _t("STOP")
	if powerup_id == "furball":
		return _t("PINK FURBALL")
	if powerup_id.begins_with("bomb_"):
		return _bomb_slot_title(powerup_id.substr(5))
	return powerup_id

func _handle_powerup_confirm_press(position: Vector2) -> void:
	if powerup_confirm_ok_rect.size.x <= 0.0:
		_layout_powerup_confirm_dialog()
	if powerup_confirm_ok_rect.has_point(position):
		_register_ui_press("confirm_ok")
		var confirm_id := powerup_confirm_id
		_clear_powerup_confirm()
		_activate_powerup_by_id(confirm_id)
		_update_prompt()
		queue_redraw()
		return
	_play_ui_click_sound()
	_clear_powerup_confirm()
	queue_redraw()

func _is_powerup_input_locked() -> bool:
	return drag_active or not mix_touch_drags.is_empty()

func _is_duplicate_powerup_press(powerup_id: String, position: Vector2) -> bool:
	if last_powerup_press_id != powerup_id:
		return false
	if _now_seconds() - last_powerup_press_time > POWERUP_DUPLICATE_PRESS_WINDOW_SECONDS:
		return false
	return position.distance_to(last_powerup_press_position) <= POWERUP_DUPLICATE_PRESS_DISTANCE

func _remember_powerup_press(powerup_id: String, position: Vector2) -> void:
	last_powerup_press_id = powerup_id
	last_powerup_press_time = _now_seconds()
	last_powerup_press_position = position

func _activate_powerup_by_id(powerup_id: String) -> void:
	if powerup_id == "aimer":
		_activate_or_buy_aimer()
		return
	if powerup_id == "freeze":
		_activate_or_buy_freeze()
		return
	for color_name in POWERUP_BOMB_COLOR_ORDER:
		if powerup_id == "bomb_%s" % color_name:
			_activate_or_buy_color_bomb(color_name)
			return
	if powerup_id == "crystal":
		_activate_or_buy_crystal_ball()
		return
	if powerup_id == "antimatter":
		_activate_or_buy_antimatter_ball()
		return
	if powerup_id == "missile":
		_activate_or_buy_missile()
		return
	if powerup_id == "furball":
		_activate_or_buy_furball()
		return

func _powerup_at(position: Vector2) -> String:
	if not _powerup_bar_contains_position(position):
		return ""
	for slot_id in _visible_powerup_slot_ids():
		var powerup_id := String(slot_id)
		var rect: Rect2 = powerup_slots.get(powerup_id, Rect2())
		if _powerup_slot_is_visible(rect) and rect.has_point(position):
			return powerup_id
	return ""

func _activate_or_buy_aimer() -> void:
	if aimer_charges > 0:
		aimer_armed = not aimer_armed
		if aimer_armed:
			_pulse_prompt(_t("Aimer equipped - %d pulls left.") % aimer_charges)
		else:
			_pulse_prompt(_t("Aimer unequipped - %d pulls kept.") % aimer_charges)
		queue_redraw()
		return
	if not _pay_powerup_cost(AIMER_COST):
		return
	aimer_charges = AIMER_CHARGE_COUNT
	aimer_armed = true
	_save_progress(current_level)
	_trigger_powerup_flash("aimer")
	_pulse_prompt(_t("Aim guide ready for %d pulls!") % aimer_charges)

func _activate_or_buy_freeze() -> void:
	if _remaining_target_count() <= 0:
		_pulse_prompt(_t("No targets to freeze."))
		return
	if not _pay_powerup_cost(FREEZE_COST):
		return
	_use_freeze()
	_trigger_powerup_flash("freeze")

func _play_sfx(stream: AudioStream) -> void:
	if sfx_player == null or stream == null:
		return
	sfx_player.stream = stream
	sfx_player.play()

func _update_missile_flight_audio() -> void:
	if missile_flight_player == null:
		return
	var flying := false
	for ball in balls:
		if not ball.is_target and ball.special_kind == "missile":
			flying = true
			break
	if flying and not missile_flight_player.playing:
		missile_flight_player.play()
	elif not flying and missile_flight_player.playing:
		missile_flight_player.stop()

func _use_freeze() -> void:
	target_freeze_timer = FREEZE_DURATION
	if freeze_sfx_player != null:
		freeze_sfx_player.play()
	_save_progress(current_level)
	_pulse_prompt(_t("Targets frozen for 5s."))

func _activate_or_buy_color_bomb(color_name: String) -> void:
	if _target_count_for_color(color_name) <= 0:
		_pulse_prompt(_t("No %s targets.") % _color_word(color_name))
		return
	if not _pay_powerup_cost(COLOR_BOMB_COST):
		return
	pending_color_bombs.append({"color": color_name, "timer": COLOR_BOMB_DELAY})
	_trigger_powerup_flash("bomb_%s" % color_name)
	_pulse_prompt(_t("%s bomb incoming!") % _color_word(color_name))

func _step_pending_bombs(delta: float) -> void:
	if pending_color_bombs.is_empty():
		return
	var remaining := []
	for entry in pending_color_bombs:
		entry["timer"] = float(entry["timer"]) - delta
		if float(entry["timer"]) <= 0.0:
			_use_color_bomb(String(entry["color"]))
		else:
			remaining.append(entry)
	pending_color_bombs = remaining

func _use_color_bomb(color_name: String) -> void:
	var destroyed := _target_count_for_color(color_name)
	if destroyed <= 0:
		_pulse_prompt(_t("No %s targets.") % _color_word(color_name))
		return
	var survivors: Array[GameBall] = []
	for ball in balls:
		if ball.is_target and ball.color_name == color_name:
			_create_explosion(ball.position, ball.color_name)
		else:
			survivors.append(ball)
	balls = survivors
	_save_progress(current_level)
	_enforce_launcher_color_caps()
	_check_level_complete()
	if not level_complete:
		_pulse_prompt(_t("%s bomb destroyed %d.") % [_color_word(color_name), destroyed])

func _activate_or_buy_crystal_ball() -> void:
	_arm_paid_special("crystal", CRYSTAL_BALL_COST)

func _activate_or_buy_antimatter_ball() -> void:
	_arm_paid_special("antimatter", ANTIMATTER_BALL_COST)

func _activate_or_buy_missile() -> void:
	_arm_paid_special("missile", MISSILE_COST)

func _activate_or_buy_furball() -> void:
	if furball_shot_armed:
		_pulse_prompt(_t("Furball armed - fire when ready!"))
		return
	if _any_furball_alive():
		_pulse_prompt(_t("A furball is already on the loose!"))
		return
	if not _pay_powerup_cost(PINK_FURBALL_COST):
		return
	furball_shot_armed = true
	_save_progress(current_level)
	_pulse_prompt(_t("Furball armed - your next shot!"))

func _arm_paid_special(special_kind: String, cost: int) -> void:
	if armed_special_kind != "":
		return
	if not _pay_powerup_cost(cost):
		return
	armed_special_kind = special_kind
	_save_progress(current_level)
	_pulse_prompt(_t("Pull a color to fire %s.") % _special_word(special_kind))

func _pay_powerup_cost(cost: int) -> bool:
	if coin_count < cost:
		_pulse_prompt(_t("Need %d coins.") % cost)
		return false
	coin_count = maxi(coin_count - cost, 0)
	return true

func _trigger_powerup_flash(powerup_id: String) -> void:
	powerup_flash_id = powerup_id
	powerup_flash_timer = POWERUP_FLASH_SECONDS
	powerup_ripple[powerup_id] = POWERUP_RIPPLE_SECONDS

func _draw_prompt_tag() -> void:
	if menu_active or prompt_label == null:
		return
	var text: String = prompt_label.text
	if text == "":
		return
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var font := PIXEL_FONT
	var font_size := int(maxf(16.0, 20.0 * scale))
	var max_text_width: float = arena.size.x - 72.0 * scale
	while font_size > 11 and font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x > max_text_width:
		font_size -= 1
	var text_width: float = font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
	var tag_size := Vector2(text_width + 30.0 * scale, font_size * 1.75)
	var tag_y: float = arena.position.y + 18.0 * scale
	if prompt_at_launcher:
		tag_y = arena.end.y + 20.0 * scale
	var tag_rect := Rect2(Vector2((viewport_size.x - tag_size.x) * 0.5, tag_y), tag_size)
	draw_style_box(_powerup_tag_style_box(), tag_rect)
	draw_string(font, Vector2(tag_rect.position.x, tag_rect.position.y + tag_size.y * 0.5 + font_size * 0.36), text, HORIZONTAL_ALIGNMENT_CENTER, tag_size.x, font_size, Color("#f3e9cf"))

func _draw_pause_overlay() -> void:
	if not game_paused or menu_active:
		return
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var font := PIXEL_FONT
	draw_rect(Rect2(Vector2.ZERO, viewport_size), Color(0.0, 0.0, 0.0, 0.42))
	var paused_font := int(maxf(30.0, 42.0 * scale))
	var paused_y: float = arena.position.y + arena.size.y * 0.46
	draw_string_outline(font, Vector2(0.0, paused_y), _t("PAUSED"), HORIZONTAL_ALIGNMENT_CENTER, viewport_size.x, paused_font, int(maxf(4.0, 6.0 * scale)), Color("#1c1206"))
	draw_string(font, Vector2(0.0, paused_y), _t("PAUSED"), HORIZONTAL_ALIGNMENT_CENTER, viewport_size.x, paused_font, Color("#f5d36a"))

func _draw_pause_button() -> void:
	if menu_active or pause_button_rect.size.x <= 0.0:
		return
	var rect := _ui_press_rect("pause", pause_button_rect)
	var center := rect.get_center()
	var shadow_offset := Vector2(0.0, rect.size.y * 0.055)
	var glow := Color(1.0, 0.86, 0.42, 0.30)
	draw_texture_rect(_glow_texture(), Rect2(center - rect.size * 0.55, rect.size * 1.1), false, glow)
	if game_paused:
		var tri_half: float = rect.size.y * 0.22
		var tri := PackedVector2Array([
			center + Vector2(-tri_half * 0.7, -tri_half),
			center + Vector2(tri_half * 1.15, 0.0),
			center + Vector2(-tri_half * 0.7, tri_half),
		])
		var tri_shadow := PackedVector2Array()
		var tri_highlight := PackedVector2Array()
		for point in tri:
			tri_shadow.append(point + shadow_offset)
			tri_highlight.append(center + (point - center) * 0.55 + Vector2(-tri_half * 0.10, -tri_half * 0.12))
		draw_colored_polygon(tri_shadow, Color(0.10, 0.05, 0.02, 0.75))
		draw_colored_polygon(tri, Color("#e8b83a"))
		draw_colored_polygon(tri_highlight, Color(1.0, 0.94, 0.72, 0.75))
	else:
		var bar_height: float = rect.size.y * 0.44
		var bar_width: float = rect.size.y * 0.15
		var bar_gap: float = rect.size.y * 0.13
		for side in [-1.0, 1.0]:
			var bar_rect := Rect2(
				center + Vector2(side * (bar_gap * 0.5 + bar_width * 0.5) - bar_width * 0.5, -bar_height * 0.5),
				Vector2(bar_width, bar_height)
			)
			draw_rect(Rect2(bar_rect.position + shadow_offset, bar_rect.size).grow(1.0), Color(0.10, 0.05, 0.02, 0.75))
			draw_rect(bar_rect, Color("#e8b83a"))
			draw_rect(Rect2(bar_rect.position, Vector2(bar_width * 0.38, bar_height)), Color(1.0, 0.94, 0.72, 0.70))
			draw_rect(Rect2(bar_rect.position + Vector2(0.0, bar_height * 0.82), Vector2(bar_width, bar_height * 0.18)), Color(0.55, 0.36, 0.08, 0.80))

func _draw_back_button() -> void:
	if menu_active or back_button_rect.size.x <= 0.0:
		return
	var rect := _ui_press_rect("back", back_button_rect)
	draw_texture_rect(PLAQUE_INFO_TEXTURE, rect, false)
	var font := PIXEL_FONT
	var label := _t("BACK")
	var back_font := int(rect.size.y * 0.50)
	while back_font > 10 and font.get_string_size(label, HORIZONTAL_ALIGNMENT_LEFT, -1, back_font).x > rect.size.x * 0.55:
		back_font -= 1
	var text_y: float = rect.position.y + rect.size.y * 0.5 + back_font * 0.36
	draw_string_outline(font, Vector2(rect.position.x, text_y), label, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, back_font, int(maxf(3.0, back_font * 0.14)), Color("#1c1206"))
	draw_string(font, Vector2(rect.position.x, text_y), label, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, back_font, Color("#f3e9cf"))

func _draw_powerup_bar() -> void:
	if powerup_slots.is_empty():
		_layout_powerup_slots()
	_draw_powerup_bar_track()
	var entries := [
		["aimer", Color("#ffd27a"), _t("AIM"), AIMER_COST, aimer_armed and aimer_charges > 0, "x%d" % aimer_charges],
		["freeze", Color("#68d8ff"), _t("STOP"), FREEZE_COST, _powerup_slot_is_flashing("freeze"), ""],
	]
	for color_name in _visible_color_bomb_order():
		entries.append(["bomb_%s" % color_name, COLOR_VALUES[color_name], _bomb_slot_title(color_name), COLOR_BOMB_COST, _powerup_slot_is_flashing("bomb_%s" % color_name), ""])
	entries.append(["crystal", Color("#f8ffff"), _t("CRYSTAL"), CRYSTAL_BALL_COST, armed_special_kind == "crystal", _t("READY")])
	entries.append(["antimatter", Color("#d8d8d8"), _t("ANTIMATTER"), ANTIMATTER_BALL_COST, armed_special_kind == "antimatter", _t("READY")])
	entries.append(["missile", Color("#ff8f2a"), _t("MSL"), MISSILE_COST, armed_special_kind == "missile", _t("READY")])
	entries.append(["furball", Color("#ff8fc0"), _t("FURBALL"), PINK_FURBALL_COST, furball_shot_armed or _any_furball_alive(), _furball_status_text()])
	var zoomed_entries := []
	for entry in entries:
		if float(powerup_press_zoom.get(entry[0], 1.0)) > 1.001:
			zoomed_entries.append(entry)
		else:
			_draw_powerup_slot(entry[0], entry[1], entry[2], entry[3], entry[4], entry[5])
	for entry in zoomed_entries:
		_draw_powerup_slot(entry[0], entry[1], entry[2], entry[3], entry[4], entry[5])
	_draw_powerup_scroll_hints()

func _draw_powerup_bar_track() -> void:
	if powerup_bar_rect.size.x <= 0.0 or powerup_bar_rect.size.y <= 0.0:
		return
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var track_rect := powerup_bar_rect.grow(3.0 * scale)
	draw_rect(track_rect, Color(0.0, 0.0, 0.0, 0.045), true)
	draw_rect(track_rect, Color(0.0, 0.0, 0.0, 0.16), false, maxf(1.0, 1.5 * scale))

func _draw_powerup_scroll_hints() -> void:
	if powerup_scroll_max <= 1.0 or powerup_bar_rect.size.x <= 0.0:
		return
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var center_y := powerup_bar_rect.position.y + powerup_bar_rect.size.y * 0.5
	var arrow_width: float = 8.0 * scale
	var arrow_height: float = 15.0 * scale
	var arrow_color := Color(0.07, 0.07, 0.07, 0.64)
	if powerup_scroll_offset > 1.0:
		var left_x: float = powerup_bar_rect.position.x + 4.0 * scale
		draw_colored_polygon(PackedVector2Array([Vector2(left_x + arrow_width, center_y - arrow_height), Vector2(left_x, center_y), Vector2(left_x + arrow_width, center_y + arrow_height)]), arrow_color)
	if powerup_scroll_offset < powerup_scroll_max - 1.0:
		var right_x: float = powerup_bar_rect.position.x + powerup_bar_rect.size.x - 4.0 * scale
		draw_colored_polygon(PackedVector2Array([Vector2(right_x - arrow_width, center_y - arrow_height), Vector2(right_x, center_y), Vector2(right_x - arrow_width, center_y + arrow_height)]), arrow_color)

func _powerup_slot_is_flashing(powerup_id: String) -> bool:
	return powerup_flash_timer > 0.0 and powerup_flash_id == powerup_id

func _draw_powerup_slot(slot_id: String, fill_color: Color, title: String, cost: int, active: bool, active_text := "") -> void:
	var rect: Rect2 = powerup_slots.get(slot_id, Rect2())
	if rect.size.x <= 0.0 or rect.size.y <= 0.0 or not _powerup_slot_is_visible(rect):
		return
	rect = _ui_press_rect("powerup_%s" % slot_id, rect)
	var zoom: float = float(powerup_press_zoom.get(slot_id, 1.0))
	if zoom > 1.001:
		rect = Rect2(rect.position - rect.size * (zoom - 1.0) * 0.5, rect.size * zoom)
	var charging := active and CHARGING_POWERUP_IDS.has(slot_id)
	var frozen := slot_id == "freeze" and target_freeze_timer > 0.0
	if charging:
		_draw_powerup_charging_aura(rect, fill_color)
	draw_texture_rect(CARD_TEXTURE, rect.grow(2.0), false)
	var icon_texture: Texture2D = null
	var icon_modulate := Color.WHITE
	if slot_id.begins_with("bomb_"):
		var bomb_color := slot_id.substr(5)
		icon_texture = BOMB_ICON_TEXTURES.get(bomb_color)
		if icon_texture == null:
			icon_texture = POWERUP_ICON_TEXTURES.get("bomb")
			icon_modulate = fill_color.lightened(0.42)
	else:
		icon_texture = POWERUP_ICON_TEXTURES.get(slot_id)
	if frozen:
		icon_texture = FREEZE_ACTIVE_ICON_TEXTURE
	if icon_texture != null:
		var icon_area := Rect2(rect.position + Vector2(rect.size.x * 0.18, rect.size.y * 0.22), Vector2(rect.size.x * 0.64, rect.size.y * 0.44))
		var icon_size := Vector2(icon_texture.get_size())
		var fit := minf(icon_area.size.x / maxf(icon_size.x, 1.0), icon_area.size.y / maxf(icon_size.y, 1.0))
		var icon_draw_size := icon_size * fit
		draw_texture_rect(icon_texture, Rect2(icon_area.position + (icon_area.size - icon_draw_size) * 0.5, icon_draw_size), false, icon_modulate)
	elif slot_id == "furball":
		var furball_center := rect.position + Vector2(rect.size.x * 0.5, rect.size.y * 0.44)
		_draw_furball_body(furball_center, rect.size.y * 0.19, effects_anim_time * 0.6)
	var font := PIXEL_FONT
	var tag_font := int(maxf(11.0, rect.size.y * 0.16))
	while tag_font > 8 and font.get_string_size(title, HORIZONTAL_ALIGNMENT_LEFT, -1, tag_font).x > rect.size.x * 0.84:
		tag_font -= 1
	var tag_text_width: float = font.get_string_size(title, HORIZONTAL_ALIGNMENT_LEFT, -1, tag_font).x
	var tag_size := Vector2(tag_text_width + rect.size.x * 0.16, tag_font * 1.55)
	var tag_rect := Rect2(Vector2(rect.position.x + (rect.size.x - tag_size.x) * 0.5, rect.position.y - tag_size.y * 0.30), tag_size)
	draw_style_box(_powerup_tag_style_box(), tag_rect)
	draw_string(font, Vector2(tag_rect.position.x, tag_rect.position.y + tag_size.y * 0.5 + tag_font * 0.36), title, HORIZONTAL_ALIGNMENT_CENTER, tag_size.x, tag_font, Color("#f3e9cf"))
	var footer_size := int(maxf(10.0, rect.size.y * 0.19))
	var footer_y = rect.position.y + rect.size.y * 0.84
	var footer_text := _powerup_slot_footer(cost, active, active_text)
	if slot_id == "furball" and (furball_shot_armed or _any_furball_alive()):
		footer_text = _furball_status_text()
	if slot_id == "aimer" and aimer_charges > 0:
		footer_text = "x%d" % aimer_charges
	draw_string_outline(font, Vector2(rect.position.x, footer_y), footer_text, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, footer_size, int(maxf(3.0, footer_size * 0.18)), Color("#3a1a02"))
	draw_string(font, Vector2(rect.position.x, footer_y), footer_text, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, footer_size, Color("#ffb300"))
	if charging:
		_draw_powerup_charging_flames(rect, fill_color)
	if frozen:
		_draw_powerup_frozen_overlay(rect)
	_draw_powerup_ripple(slot_id, rect, fill_color)

func _draw_powerup_charging_aura(rect: Rect2, color: Color) -> void:
	var pulse := 0.5 + 0.5 * sin(effects_anim_time * 5.5)
	var aura := color.lightened(0.30)
	aura.a = 0.50 + 0.25 * pulse
	draw_texture_rect(_glow_texture(), rect.grow(rect.size.x * (0.34 + 0.12 * pulse)), false, aura)
	var inner := color.lightened(0.55)
	inner.a = 0.22 + 0.14 * pulse
	draw_texture_rect(_glow_texture(), rect.grow(-rect.size.x * 0.06), false, inner)

func _draw_powerup_charging_flames(rect: Rect2, color: Color) -> void:
	var glow := _glow_texture()
	for k in range(9):
		var seed := float(k) * 7.31
		var perim := fposmod(seed * 0.173, 1.0)
		var base_position: Vector2
		if perim < 0.3:
			base_position = Vector2(rect.position.x + 2.0, rect.position.y + rect.size.y * (1.0 - perim / 0.3))
		elif perim < 0.7:
			base_position = Vector2(rect.position.x + rect.size.x * ((perim - 0.3) / 0.4), rect.position.y + 2.0)
		else:
			base_position = Vector2(rect.end.x - 2.0, rect.position.y + rect.size.y * ((perim - 0.7) / 0.3))
		var speed := 0.8 + fposmod(seed * 0.517, 0.7)
		var life := fposmod(effects_anim_time * speed + seed, 1.0)
		var rise := life * rect.size.y * 0.42
		var flame_position := base_position + Vector2(sin(effects_anim_time * 6.0 + seed) * 3.5, -rise)
		var flame_alpha := (1.0 - life) * 0.85
		var flame_size := rect.size.y * (0.22 + 0.14 * (1.0 - life))
		var flame_color := color.lightened(0.25 + 0.45 * (1.0 - life))
		flame_color.a = flame_alpha
		draw_texture_rect(glow, Rect2(flame_position - Vector2(flame_size * 0.5, flame_size * 0.5), Vector2(flame_size, flame_size)), false, flame_color)
		var core_color := Color(1.0, 0.98, 0.90, flame_alpha * 0.8)
		draw_texture_rect(glow, Rect2(flame_position - Vector2(flame_size * 0.25, flame_size * 0.3), Vector2(flame_size * 0.5, flame_size * 0.6)), false, core_color)

func _draw_powerup_frozen_overlay(rect: Rect2) -> void:
	var glow := _glow_texture()
	var ice := Color(0.62, 0.86, 1.0, 0.30 + 0.10 * sin(effects_anim_time * 4.0))
	draw_texture_rect(glow, rect.grow(rect.size.x * 0.14), false, ice)
	for k in range(6):
		var seed := float(k) * 5.13
		var sparkle_position := rect.position + Vector2(fposmod(seed * 0.373, 1.0) * rect.size.x, rect.size.y * 0.06 + fposmod(seed * 0.719, 1.0) * rect.size.y * 0.68)
		var twinkle := 0.5 + 0.5 * sin(effects_anim_time * 6.0 + seed)
		var sparkle_color := Color(0.90, 0.98, 1.0, 0.35 + 0.55 * twinkle)
		var arm := rect.size.y * (0.04 + 0.05 * twinkle)
		draw_line(sparkle_position - Vector2(arm, 0.0), sparkle_position + Vector2(arm, 0.0), sparkle_color, 1.5, true)
		draw_line(sparkle_position - Vector2(0.0, arm), sparkle_position + Vector2(0.0, arm), sparkle_color, 1.5, true)
	var thaw := clampf(target_freeze_timer / FREEZE_DURATION, 0.0, 1.0)
	draw_rect(Rect2(rect.position + Vector2(rect.size.x * 0.10, rect.size.y * 0.955), Vector2(rect.size.x * 0.80 * thaw, 3.0)), Color(0.70, 0.92, 1.0, 0.85))

func _draw_powerup_ripple(slot_id: String, rect: Rect2, fill_color: Color) -> void:
	if slot_id == "freeze":
		return
	var remaining: float = float(powerup_ripple.get(slot_id, 0.0))
	if remaining <= 0.0:
		return
	var p := clampf(1.0 - remaining / POWERUP_RIPPLE_SECONDS, 0.0, 1.0)
	var glow := _glow_texture()
	var flash := fill_color.lightened(0.55)
	flash.a = (1.0 - p) * (1.0 - p) * 0.70
	draw_texture_rect(glow, rect.grow(-rect.size.x * 0.05), false, flash)
	var center := rect.get_center()
	var ring_radius: float = rect.size.x * (0.30 + 0.78 * p)
	for k in range(12):
		var angle := float(k) * TAU / 12.0 + p * 1.2
		var speck_position := center + Vector2(cos(angle), sin(angle)) * ring_radius
		var speck_size: float = rect.size.x * 0.22 * (1.0 - p * 0.55)
		var speck_color := fill_color.lightened(0.40)
		speck_color.a = (1.0 - p) * 0.92
		draw_texture_rect(glow, Rect2(speck_position - Vector2(speck_size * 0.5, speck_size * 0.5), Vector2(speck_size, speck_size)), false, speck_color)
		var speck_core := Color(1.0, 0.98, 0.90, (1.0 - p) * 0.8)
		draw_texture_rect(glow, Rect2(speck_position - Vector2(speck_size * 0.22, speck_size * 0.22), Vector2(speck_size * 0.44, speck_size * 0.44)), false, speck_core)

func _bomb_slot_title(color_name: String) -> String:
	# Full name everywhere the bomb is labeled (card tag + confirm dialog):
	# zh "红色炸弹" / zh_hant "紅色炸彈" / en "RED BOMB".
	if _is_zh_lang():
		return _t("%s BOMB") % _color_word(color_name)
	return "%s BOMB" % color_name.to_upper()

func _powerup_slot_is_visible(rect: Rect2) -> bool:
	if powerup_bar_rect.size.x <= 0.0 or powerup_bar_rect.size.y <= 0.0:
		return true
	return rect.position.x + rect.size.x >= powerup_bar_rect.position.x and rect.position.x <= powerup_bar_rect.position.x + powerup_bar_rect.size.x

func _furball_status_text() -> String:
	var best_life := -1.0
	for ball in balls:
		if not ball.is_target and ball.is_furball:
			best_life = maxf(best_life, PINK_FURBALL_LIFETIME if ball.furball_life < 0.0 else ball.furball_life)
	if best_life >= 0.0:
		return "%ds" % int(ceilf(best_life))
	if furball_shot_armed:
		return "x1"
	return ""

func _powerup_slot_footer(cost: int, active: bool, active_text := "") -> String:
	if active and active_text != "":
		return active_text
	return "$%d" % cost

static func _make_pixel_font_bold() -> FontVariation:
	var bold := FontVariation.new()
	bold.base_font = PIXEL_FONT
	bold.variation_embolden = 1.2
	return bold

func _draw_level_complete_panel() -> void:
	if not level_complete:
		return
	if level_complete_panel_rect.size.x <= 0.0:
		_layout_level_complete_panel()
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var overlay_rect := Rect2(Vector2.ZERO, viewport_size)
	var base_rect := level_complete_panel_rect
	var pop = 0.94 + 0.06 * clampf(level_complete_anim_time / 0.18, 0.0, 1.0)
	var rect := Rect2(base_rect.position + base_rect.size * (1.0 - pop) * 0.5, base_rect.size * pop)
	var font := PIXEL_FONT
	draw_rect(overlay_rect, Color(0.0, 0.0, 0.0, 0.38))
	_draw_complete_panel_sparkles(rect, scale)
	draw_texture_rect(COMPLETE_PANEL_TEXTURE, rect, false)
	var inner := Rect2(
		rect.position + rect.size * Vector2(COMPLETE_INNER_X0, COMPLETE_INNER_Y0),
		rect.size * Vector2(COMPLETE_INNER_X1 - COMPLETE_INNER_X0, COMPLETE_INNER_Y1 - COMPLETE_INNER_Y0)
	)
	var title_size := int(maxf(24.0, 34.0 * scale))
	while title_size > 18 and font.get_string_size(_t("LEVEL CLEAR!"), HORIZONTAL_ALIGNMENT_LEFT, -1, title_size).x > inner.size.x - 8.0:
		title_size -= 1
	var title_y: float = inner.position.y + inner.size.y * 0.10
	draw_string_outline(font, Vector2(inner.position.x, title_y), _t("LEVEL CLEAR!"), HORIZONTAL_ALIGNMENT_CENTER, inner.size.x, title_size, int(maxf(4.0, 6.0 * scale)), Color("#1c1206"))
	draw_string(font, Vector2(inner.position.x, title_y), _t("LEVEL CLEAR!"), HORIZONTAL_ALIGNMENT_CENTER, inner.size.x, title_size, Color("#f5d36a"))
	var displayed_perfect := _displayed_level_complete_perfect_hits()
	var displayed_shots := _displayed_level_complete_remaining_shots()
	var displayed_perfect_bonus := _animated_level_complete_count(last_level_perfect_bonus, COMPLETE_PERFECT_COUNT_DELAY, COMPLETE_PERFECT_COUNT_SECONDS, true)
	var displayed_shot_bonus := _animated_level_complete_count(last_level_shot_bonus, COMPLETE_SHOT_COUNT_DELAY, COMPLETE_SHOT_COUNT_SECONDS, true)
	var displayed_reward := _displayed_level_complete_coin_reward()
	var row_font := int(maxf(18.0, 24.0 * scale))
	_draw_complete_reward_row(font, inner, inner.position.y + inner.size.y * 0.24, row_font, _t("BASE"), "", "+%d" % last_level_base_reward, Color("#f3e9cf"))
	_draw_complete_reward_row(font, inner, inner.position.y + inner.size.y * 0.35, row_font, _t("PERFECT"), "x%d/%d" % [displayed_perfect, level_perfect_hits], "+%d" % displayed_perfect_bonus, Color("#7fd0f5"))
	_draw_complete_reward_row(font, inner, inner.position.y + inner.size.y * 0.46, row_font, _t("SHOTS LEFT"), "%d/%d" % [displayed_shots, last_level_remaining_shots], "+%d" % displayed_shot_bonus, Color("#8fe6b0"))
	var total_y: float = inner.position.y + inner.size.y * 0.60
	var coins_label := _t("COINS")
	var coins_label_width: float = font.get_string_size(coins_label, HORIZONTAL_ALIGNMENT_LEFT, -1, row_font).x
	draw_string(font, Vector2(inner.position.x, total_y), coins_label, HORIZONTAL_ALIGNMENT_LEFT, inner.size.x * 0.45, row_font, Color("#f3e9cf"))
	_draw_coin_icon(Vector2(inner.position.x + coins_label_width + 22.0 * scale, total_y - row_font * 0.30), 13.0 * scale, 1.0)
	draw_string(font, Vector2(inner.position.x, total_y), "+%d" % displayed_reward, HORIZONTAL_ALIGNMENT_RIGHT, inner.size.x, row_font, Color("#ffd27a"))
	var balance_font := int(maxf(17.0, 22.0 * scale))
	var balance_segments := [[_t("BALANCE "), false], [str(_displayed_level_complete_coin_total()), true]]
	while balance_font > 12 and _segments_width(font, balance_segments, balance_font) > inner.size.x - 8.0:
		balance_font -= 1
	var balance_x: float = inner.position.x + (inner.size.x - _segments_width(font, balance_segments, balance_font)) * 0.5
	_draw_text_segments(font, Vector2(balance_x, inner.position.y + inner.size.y * 0.74), balance_segments, balance_font)
	var pulse = 0.72 + 0.28 * abs(sin(level_complete_anim_time * 3.2))
	var action_text := _level_complete_action_text()
	var action_font := int(maxf(17.0, 22.0 * scale))
	while action_font > 12 and pixel_font_bold.get_string_size(action_text, HORIZONTAL_ALIGNMENT_LEFT, -1, action_font).x > inner.size.x - 8.0:
		action_font -= 1
	draw_string(pixel_font_bold, Vector2(inner.position.x, inner.position.y + inner.size.y * 0.90), action_text, HORIZONTAL_ALIGNMENT_CENTER, inner.size.x, action_font, Color(0.95, 0.91, 0.81, pulse))

func _draw_complete_reward_row(font: Font, inner: Rect2, row_y: float, row_font: int, label: String, count_text: String, bonus_text: String, accent: Color) -> void:
	var gap_total: float = 24.0 if count_text == "" else 48.0
	var label_width: float = font.get_string_size(label, HORIZONTAL_ALIGNMENT_LEFT, -1, row_font).x
	var bonus_width: float = font.get_string_size(bonus_text, HORIZONTAL_ALIGNMENT_LEFT, -1, row_font).x
	var count_width: float = font.get_string_size(count_text, HORIZONTAL_ALIGNMENT_LEFT, -1, row_font).x if count_text != "" else 0.0
	while row_font > 12 and label_width + count_width + bonus_width + gap_total > inner.size.x:
		row_font -= 1
		label_width = font.get_string_size(label, HORIZONTAL_ALIGNMENT_LEFT, -1, row_font).x
		bonus_width = font.get_string_size(bonus_text, HORIZONTAL_ALIGNMENT_LEFT, -1, row_font).x
		count_width = font.get_string_size(count_text, HORIZONTAL_ALIGNMENT_LEFT, -1, row_font).x if count_text != "" else 0.0
	draw_string(font, Vector2(inner.position.x, row_y), label, HORIZONTAL_ALIGNMENT_LEFT, label_width + 8.0, row_font, Color("#f3e9cf"))
	draw_string(font, Vector2(inner.position.x, row_y), bonus_text, HORIZONTAL_ALIGNMENT_RIGHT, inner.size.x, row_font, Color("#ffd27a"))
	if count_text != "":
		var slot_start: float = inner.position.x + label_width + 12.0
		var slot_end: float = inner.end.x - bonus_width - 12.0
		var count_x: float = slot_start + maxf((slot_end - slot_start - count_width) * 0.5, 0.0)
		draw_string(font, Vector2(count_x, row_y), count_text, HORIZONTAL_ALIGNMENT_LEFT, count_width + 8.0, row_font, accent)

func _draw_complete_panel_sparkles(rect: Rect2, scale: float) -> void:
	for index in range(8):
		var angle = float(index) * TAU / 8.0 + level_complete_anim_time * 0.85
		var radius = rect.size.x * 0.50 + sin(level_complete_anim_time * 2.3 + float(index)) * 10.0 * scale
		var center = rect.get_center() + Vector2(cos(angle), sin(angle)) * radius * 0.52
		var alpha = 0.34 + 0.22 * sin(level_complete_anim_time * 4.0 + float(index))
		_draw_coin_icon(center, (7.0 + float(index % 3) * 1.8) * scale, alpha)

func _draw_coin_icon(center: Vector2, radius: float, alpha: float) -> void:
	var coin_color := Color(1.0, 0.78, 0.13, clampf(alpha, 0.0, 1.0))
	draw_circle(center, radius, Color(0.0, 0.0, 0.0, coin_color.a * 0.34))
	draw_circle(center + Vector2(0.0, -radius * 0.10), radius * 0.86, coin_color)
	draw_arc(center + Vector2(0.0, -radius * 0.10), radius * 0.58, -PI * 0.35, PI * 1.35, 24, Color(1.0, 1.0, 1.0, coin_color.a * 0.52), maxf(1.0, radius * 0.16))

func _draw_level_intro_dialog() -> void:
	if not level_intro_active:
		return
	if level_intro_dialog_rect.size.x <= 0.0:
		_layout_level_intro_dialog()
	_draw_info_dialog(level_intro_dialog_rect, level_intro_ok_rect, level_intro_title, level_intro_lines, "intro_ok")

func _draw_trial_end_dialog() -> void:
	if not trial_end_active:
		return
	if trial_end_dialog_rect.size.x <= 0.0:
		_layout_trial_end_dialog()
	var lines := [_t("You've cleared the POP'EM! demo. Thank you for playing!"), _t("The full version is coming soon. Stay tuned!")]
	_draw_info_dialog(trial_end_dialog_rect, trial_end_ok_rect, _t("DEMO COMPLETE!"), lines, "trial_end_ok", "", COMPLETE_PANEL_TEXTURE, COMPLETE_INNER_X0, COMPLETE_INNER_X1, COMPLETE_INNER_Y0)

func _draw_powerup_help_dialog() -> void:
	if not powerup_help_active:
		return
	if powerup_help_dialog_rect.size.x <= 0.0:
		_layout_powerup_help_dialog()
	_draw_info_dialog(powerup_help_dialog_rect, powerup_help_ok_rect, powerup_help_title, powerup_help_lines, "help_ok")
	_draw_confirm_button(_ui_press_rect("help_cancel", powerup_help_cancel_rect), _t("CANCEL"))

func _draw_powerup_confirm_dialog() -> void:
	if not powerup_confirm_active:
		return
	if powerup_confirm_dialog_rect.size.x <= 0.0:
		_layout_powerup_confirm_dialog()
	var lines := [_t("Cost $%d") % _powerup_cost_for_id(powerup_confirm_id), _t("Use it now?")]
	_draw_info_dialog(powerup_confirm_dialog_rect, powerup_confirm_ok_rect, _powerup_confirm_title(powerup_confirm_id), lines, "confirm_ok", _t("CONFIRM"))

func _draw_level_failed_dialog() -> void:
	if not level_failed:
		return
	if level_failed_dialog_rect.size.x <= 0.0:
		_layout_level_failed_dialog()
	var cost := _extra_shot_cost()
	var lines := []
	var ok_text := ""
	if coin_count >= cost:
		lines = [_t("All shots are used up."), _t("Buy +%d shots for $%d") % [EXTRA_SHOTS_PER_BUY, cost], _t("and keep popping?")]
		ok_text = _t("BUY +%d") % EXTRA_SHOTS_PER_BUY
	else:
		lines = [_t("All shots are used up."), _t("Extra shots cost $%d.") % cost, _t("Not enough coins - retry!")]
		ok_text = _t("RETRY")
	_draw_info_dialog(level_failed_dialog_rect, level_failed_ok_rect, _t("OUT OF SHOTS"), lines, "failed_ok", ok_text)

func _draw_info_dialog(rect: Rect2, ok_rect: Rect2, title: String, lines: Array, ok_id := "", ok_text := "", panel_texture: Texture2D = TUTORIAL_PANEL_TEXTURE, inner_x0 := TUTORIAL_INNER_X0, inner_x1 := TUTORIAL_INNER_X1, inner_y0 := TUTORIAL_INNER_Y0) -> void:
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var overlay_rect := Rect2(Vector2.ZERO, viewport_size)
	var font := PIXEL_FONT
	draw_rect(overlay_rect, Color(0.0, 0.0, 0.0, 0.42))
	draw_texture_rect(panel_texture, rect, false)
	var inner_x: float = rect.position.x + rect.size.x * inner_x0
	var inner_width: float = rect.size.x * (inner_x1 - inner_x0)
	var inner_top: float = rect.position.y + rect.size.y * inner_y0
	var content_bottom: float = ok_rect.position.y - 12.0 * scale
	var title_size := int(maxf(22.0, 34.0 * scale))
	while title_size > 16 and font.get_string_size(title, HORIZONTAL_ALIGNMENT_LEFT, -1, title_size).x > inner_width - 6.0:
		title_size -= 1
	var title_gap = 26.0 * scale
	var body_size := int(maxf(16.0, 21.0 * scale))
	var body_lines: Array = lines
	var line_gap := 0.0
	var block_height := 0.0
	while true:
		body_lines = _wrap_dialog_lines(font, lines, body_size, inner_width - 6.0)
		line_gap = maxf(26.0 * scale, float(body_size) * 1.5)
		block_height = float(title_size) + title_gap + float(body_size) + line_gap * float(maxi(body_lines.size() - 1, 0))
		if body_size <= 12 or block_height <= content_bottom - inner_top:
			break
		body_size -= 1
	var block_top: float = inner_top + maxf((content_bottom - inner_top - block_height) * 0.5, 0.0)
	var title_y: float = block_top + float(title_size)
	draw_string_outline(font, Vector2(inner_x, title_y), title, HORIZONTAL_ALIGNMENT_CENTER, inner_width, title_size, int(maxf(3.0, 5.0 * scale)), Color("#1c1206"))
	draw_string(font, Vector2(inner_x, title_y), title, HORIZONTAL_ALIGNMENT_CENTER, inner_width, title_size, Color("#f5d36a"))
	var line_y: float = title_y + title_gap + float(body_size)
	for line in body_lines:
		draw_string(font, Vector2(inner_x, line_y), String(line), HORIZONTAL_ALIGNMENT_CENTER, inner_width, body_size, Color("#f3e9cf"))
		line_y += line_gap
	_draw_confirm_button(_ui_press_rect(ok_id, ok_rect), ok_text if ok_text != "" else _t("OK"))

func _draw_confirm_button(rect: Rect2, text: String) -> void:
	if rect.size.x <= 0.0:
		return
	var font := PIXEL_FONT
	var texture_size := Vector2(CONFIRM_BUTTON_TEXTURE.get_size())
	var fit := minf(rect.size.x / maxf(texture_size.x, 1.0), rect.size.y / maxf(texture_size.y, 1.0))
	var draw_size := texture_size * fit
	var capsule := Rect2(rect.position + (rect.size - draw_size) * 0.5, draw_size)
	draw_texture_rect(CONFIRM_BUTTON_TEXTURE, capsule, false)
	var glass_x: float = capsule.position.x + capsule.size.x * 0.24
	var glass_width: float = capsule.size.x * 0.52
	var font_size := int(maxf(18.0, capsule.size.y * 0.36))
	while font_size > 12 and font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x > glass_width - 8.0:
		font_size -= 1
	var text_y: float = capsule.position.y + capsule.size.y * 0.485 + font_size * 0.36
	draw_string_outline(font, Vector2(glass_x, text_y), text, HORIZONTAL_ALIGNMENT_CENTER, glass_width, font_size, int(maxf(3.0, capsule.size.y * 0.07)), Color("#10300a"))
	draw_string(font, Vector2(glass_x, text_y), text, HORIZONTAL_ALIGNMENT_CENTER, glass_width, font_size, Color("#f4ffe8"))

func _wrap_dialog_lines(font: Font, lines: Array, font_size: int, width: float) -> Array:
	var wrapped: Array = []
	for line in lines:
		var text := String(line)
		while text.length() > 1 and font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x > width:
			var break_index := _wrap_break_index(font, text, font_size, width)
			wrapped.append(text.substr(0, break_index).strip_edges())
			text = text.substr(break_index).strip_edges()
		wrapped.append(text)
	return wrapped

func _wrap_break_index(font: Font, text: String, font_size: int, width: float) -> int:
	var fit := 1
	while fit < text.length() and font.get_string_size(text.substr(0, fit + 1), HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x <= width:
		fit += 1
	if fit >= text.length():
		return fit
	var space_index := text.rfind(" ", fit - 1)
	if space_index > 0:
		return space_index + 1
	if fit > 1 and "，。！？；：、）】》”".contains(text[fit]):
		return fit - 1
	return fit

func _draw_start_menu() -> void:
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var font := PIXEL_FONT
	_draw_menu_background(viewport_size)
	_draw_menu_star_twinkles(viewport_size, scale)
	var logo_texture: Texture2D = MENU_LOGO_CN_TEXTURE if _is_zh_lang() else MENU_LOGO_TEXTURE
	var logo_texture_size := Vector2(logo_texture.get_size())
	var logo_width: float = 420.0 * scale
	var logo_height: float = logo_width * logo_texture_size.y / maxf(logo_texture_size.x, 1.0)
	var logo_position := Vector2((viewport_size.x - logo_width) * 0.5, viewport_size.y * 0.185)
	var logo_bob := Vector2(0.0, sin(menu_anim_time * 0.8) * 5.0 * scale)
	draw_texture_rect(logo_texture, Rect2(logo_position + logo_bob, Vector2(logo_width, logo_height)), false)
	var left_segments := [[_t("Level "), false], [str(current_level), true]]
	var right_segments := [[_t("Coins "), false], [str(coin_count), true]]
	var info_plaque := Rect2(Vector2((viewport_size.x - 500.0 * scale) * 0.5, logo_position.y + logo_height + 58.0 * scale), Vector2(500.0 * scale, 96.0 * scale))
	draw_texture_rect(PLAQUE_TEXTURE, info_plaque, false)
	var info_size := int(40.0 * scale)
	var info_width: float = info_plaque.size.x * 0.56
	var icon_gap: float = 14.0 * scale
	while info_size > 12:
		var probe_total: float = _segments_width(PIXEL_FONT, left_segments, info_size) + _segments_width(PIXEL_FONT, right_segments, info_size) + info_size * 1.35 + icon_gap * 2.0
		if probe_total <= info_width - 4.0:
			break
		info_size -= 1
	var left_width: float = _segments_width(PIXEL_FONT, left_segments, info_size)
	var right_width: float = _segments_width(PIXEL_FONT, right_segments, info_size)
	var icon_side: float = info_size * 1.35
	var group_width: float = left_width + right_width + icon_side + icon_gap * 2.0
	var group_x: float = info_plaque.position.x + (info_plaque.size.x - group_width) * 0.5
	var info_y: float = info_plaque.position.y + info_plaque.size.y * 0.60
	_draw_text_segments(PIXEL_FONT, Vector2(group_x, info_y), left_segments, info_size)
	var icon_rect := Rect2(Vector2(group_x + left_width + icon_gap, info_y - info_size * 0.34 - icon_side * 0.5), Vector2(icon_side, icon_side))
	draw_texture_rect(TRINITY_TEXTURE, icon_rect, false)
	_draw_text_segments(PIXEL_FONT, Vector2(group_x + left_width + icon_gap * 2.0 + icon_side, info_y), right_segments, info_size)
	_draw_menu_button("continue", _t("CONTINUE"))
	_draw_menu_button("restart", _t("NEW GAME"))
	_draw_menu_button("settings", _t("SETTING"))
	if settings_active:
		_draw_settings_menu()
	elif level_select_active:
		_draw_level_select()

func _draw_level_select() -> void:
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	if level_select_buttons.is_empty():
		_layout_level_select()
	draw_rect(Rect2(Vector2.ZERO, viewport_size), Color(0.05, 0.03, 0.10, 0.94), true)
	var font := PIXEL_FONT
	var title := _t("SELECT LEVEL")
	var title_size := int(38.0 * scale)
	var title_y: float = viewport_size.y * 0.20 - 34.0 * scale
	draw_string_outline(font, Vector2(0.0, title_y), title, HORIZONTAL_ALIGNMENT_CENTER, viewport_size.x, title_size, int(maxf(4.0, 5.0 * scale)), Color("#1c1206"))
	draw_string(font, Vector2(0.0, title_y), title, HORIZONTAL_ALIGNMENT_CENTER, viewport_size.x, title_size, Color("#f5d36a"))
	for index in range(LEVEL_TARGET_COUNTS.size()):
		var level := index + 1
		var rect: Rect2 = _ui_press_rect("level_pick_%d" % level, level_select_buttons.get("level_%d" % level, Rect2()))
		var unlocked := level <= highest_level
		var chip_tint := Color.WHITE if unlocked else Color(0.55, 0.55, 0.55, 0.45)
		draw_texture_rect(PLAQUE_INFO_TEXTURE, rect, false, chip_tint)
		if level == current_level and unlocked:
			draw_rect(rect.grow(3.0 * scale), Color("#f5d36a"), false, maxf(2.0, 3.0 * scale))
		var label := str(level)
		var chip_font := int(rect.size.y * 0.44)
		var text_y: float = rect.position.y + rect.size.y * 0.5 + chip_font * 0.36
		var number_color := Color("#f3e9cf") if unlocked else Color(0.75, 0.72, 0.66, 0.55)
		draw_string_outline(font, Vector2(rect.position.x, text_y), label, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, chip_font, int(maxf(3.0, chip_font * 0.14)), Color("#1c1206"))
		draw_string(font, Vector2(rect.position.x, text_y), label, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, chip_font, number_color)
	var back_rect: Rect2 = _ui_press_rect("level_select_back", level_select_buttons.get("back", Rect2()))
	_draw_capsule_button(back_rect, _t("BACK"), MENU_BUTTON_BLUE_TEXTURE, 0.6)

func _draw_menu_background(viewport_size: Vector2) -> void:
	var texture_size := Vector2(MENU_BACKGROUND_TEXTURE.get_size())
	if texture_size.x <= 0.0 or texture_size.y <= 0.0:
		return
	var drift_zoom := 1.05 + 0.03 * sin(menu_anim_time * 0.13)
	var cover_scale := maxf(viewport_size.x / texture_size.x, viewport_size.y / texture_size.y) * drift_zoom
	var draw_size := texture_size * cover_scale
	var drift_offset := Vector2(sin(menu_anim_time * 0.07), cos(menu_anim_time * 0.09)) * minf(viewport_size.x, viewport_size.y) * 0.008
	var draw_position := (viewport_size - draw_size) * 0.5 + drift_offset
	draw_texture_rect(MENU_BACKGROUND_TEXTURE, Rect2(draw_position, draw_size), false)

func _draw_menu_star_twinkles(viewport_size: Vector2, scale: float) -> void:
	for index in range(16):
		var hash_a := fposmod(sin(float(index) * 78.233 + 1.0) * 43758.547, 1.0)
		var hash_b := fposmod(sin(float(index) * 12.989 + 4.0) * 24634.629, 1.0)
		var hash_c := fposmod(sin(float(index) * 39.425 + 7.0) * 11369.833, 1.0)
		var star_position := Vector2(
			(0.08 + 0.84 * hash_a) * viewport_size.x,
			(0.04 + 0.52 * hash_b) * viewport_size.y)
		var pulse := sin(menu_anim_time * (0.8 + 1.6 * hash_c) + hash_a * TAU)
		var alpha := clampf(pulse, 0.0, 1.0)
		alpha = alpha * alpha * 0.8
		if alpha <= 0.02:
			continue
		var star_size := (1.4 + 2.2 * hash_c) * scale
		var star_color := Color(1.0, 0.95, 0.78, alpha)
		draw_circle(star_position, star_size * 0.55, star_color)
		var ray := star_size * 2.2
		var ray_color := Color(1.0, 0.95, 0.78, alpha * 0.55)
		draw_line(star_position + Vector2(-ray, 0.0), star_position + Vector2(ray, 0.0), ray_color, maxf(1.0, 0.8 * scale))
		draw_line(star_position + Vector2(0.0, -ray), star_position + Vector2(0.0, ray), ray_color, maxf(1.0, 0.8 * scale))

func _draw_menu_button(button_id: String, text: String) -> void:
	var rect: Rect2 = _ui_press_rect("menu_%s" % button_id, start_menu_buttons.get(button_id, Rect2()))
	var texture: Texture2D = MENU_BUTTON_TEXTURE
	var sheen_phase := 0.0
	if button_id == "restart":
		texture = MENU_BUTTON_AMBER_TEXTURE
		sheen_phase = 0.95
	elif button_id == "settings":
		texture = MENU_BUTTON_BLUE_TEXTURE
		sheen_phase = 1.9
	_draw_capsule_button(rect, text, texture, sheen_phase)

func _draw_button_sheen(capsule: Rect2, phase: float) -> void:
	var cycle := 3.2
	var t := fposmod(menu_anim_time + phase, cycle) / cycle
	if t > 0.45:
		return
	var progress := t / 0.45
	var glass_h: float = capsule.size.y * 0.62
	var sweep_x: float = lerpf(capsule.position.x + capsule.size.x * 0.15, capsule.position.x + capsule.size.x * 0.85, progress)
	var fade := sin(progress * PI) * 0.9
	var glow := _glow_texture()
	var center := Vector2(sweep_x, capsule.position.y + capsule.size.y * 0.42)
	draw_set_transform(center, -0.52, Vector2.ONE)
	var main_size := Vector2(glass_h * 0.42, glass_h * 1.15)
	draw_texture_rect(glow, Rect2(-main_size * 0.5, main_size), false, Color(1.0, 0.99, 0.92, 0.55 * fade))
	var core_size := Vector2(glass_h * 0.20, glass_h * 1.0)
	draw_texture_rect(glow, Rect2(-core_size * 0.5, core_size), false, Color(1.0, 1.0, 1.0, 0.50 * fade))
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	var trail_center := center + Vector2(-glass_h * 0.55, 0.0)
	draw_set_transform(trail_center, -0.52, Vector2.ONE)
	var trail_size := Vector2(glass_h * 0.16, glass_h * 0.8)
	draw_texture_rect(glow, Rect2(-trail_size * 0.5, trail_size), false, Color(1.0, 1.0, 1.0, 0.30 * fade))
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	var arc_center := Vector2(sweep_x, capsule.position.y + capsule.size.y * 0.30)
	var arc_size := Vector2(glass_h * 1.6, glass_h * 0.34)
	draw_texture_rect(glow, Rect2(arc_center - arc_size * 0.5, arc_size), false, Color(1.0, 1.0, 1.0, 0.28 * fade))

func _draw_capsule_button(rect: Rect2, text: String, texture: Texture2D, sheen_phase := -1.0, tint := Color.WHITE) -> void:
	if rect.size.x <= 0.0:
		return
	var font := PIXEL_FONT
	var texture_size := Vector2(texture.get_size())
	var fit_scale := minf(rect.size.x / maxf(texture_size.x, 1.0), rect.size.y / maxf(texture_size.y, 1.0))
	var draw_size := texture_size * fit_scale
	var capsule := Rect2(rect.position + (rect.size - draw_size) * 0.5, draw_size)
	draw_texture_rect(texture, capsule, false, tint)
	if sheen_phase >= 0.0:
		_draw_button_sheen(capsule, sheen_phase)
	var font_size := int(maxf(20.0, rect.size.y * 0.30))
	var text_padding: float = draw_size.x * 0.22
	var text_x: float = rect.position.x + (rect.size.x - draw_size.x) * 0.5 + text_padding
	var text_width: float = draw_size.x - text_padding * 2.0
	while font_size > 14 and font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x > text_width - 4.0:
		font_size -= 1
	var text_y = rect.position.y + rect.size.y * 0.61
	var text_color := Color("#fdf6e3") if tint == Color.WHITE else Color("#fdf6e3", 0.62)
	draw_string_outline(font, Vector2(text_x, text_y), text, HORIZONTAL_ALIGNMENT_CENTER, text_width, font_size, int(maxf(3.0, rect.size.y * 0.06)), Color("#3a1206"))
	draw_string(font, Vector2(text_x, text_y), text, HORIZONTAL_ALIGNMENT_CENTER, text_width, font_size, text_color)

func _draw_settings_menu() -> void:
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var font := PIXEL_FONT
	draw_rect(Rect2(Vector2.ZERO, viewport_size), Color(0.0, 0.0, 0.0, 0.4))
	draw_texture_rect(MENU_PANEL_TEXTURE, settings_panel_rect, false)
	var title_size := int(maxf(24.0, 32.0 * scale))
	var title_y: float = settings_panel_rect.position.y + 88.0 * scale
	draw_string_outline(font, Vector2(settings_panel_rect.position.x, title_y), _t("SETTINGS"), HORIZONTAL_ALIGNMENT_CENTER, settings_panel_rect.size.x, title_size, int(maxf(3.0, 5.0 * scale)), Color("#1c1206"))
	draw_string(font, Vector2(settings_panel_rect.position.x, title_y), _t("SETTINGS"), HORIZONTAL_ALIGNMENT_CENTER, settings_panel_rect.size.x, title_size, Color("#f5d36a"))
	var language_options := [["en", "ENGLISH"], ["zh", "简体中文"], ["zh_hant", "繁體中文"]]
	for option in language_options:
		var lang: String = option[0]
		var selected := settings_language == lang
		var lang_rect: Rect2 = _ui_press_rect("settings_lang_%s" % lang, settings_buttons.get("lang_%s" % lang, Rect2()))
		var lang_tint := Color.WHITE if selected else Color(0.52, 0.50, 0.56)
		_draw_capsule_button(lang_rect, String(option[1]), MENU_BUTTON_PURPLE_TEXTURE, -1.0, lang_tint)
		if selected:
			var marker_size := int(maxf(16.0, lang_rect.size.y * 0.34))
			var marker_y: float = lang_rect.position.y + lang_rect.size.y * 0.62
			draw_string(font, Vector2(lang_rect.position.x + lang_rect.size.x * 0.075, marker_y), "»", HORIZONTAL_ALIGNMENT_LEFT, -1, marker_size, Color("#ffd873"))
			draw_string(font, Vector2(lang_rect.position.x, marker_y), "«", HORIZONTAL_ALIGNMENT_RIGHT, lang_rect.size.x * 0.925, marker_size, Color("#ffd873"))
	var volume_down_rect: Rect2 = settings_buttons.get("volume_down", Rect2())
	var volume_up_rect: Rect2 = settings_buttons.get("volume_up", Rect2())
	var volume_text_x: float = volume_down_rect.end.x
	var volume_text_width: float = volume_up_rect.position.x - volume_text_x
	var volume_caption_y: float = volume_down_rect.position.y - 14.0 * scale
	var volume_caption_size := int(maxf(16.0, 20.0 * scale))
	draw_string_outline(font, Vector2(volume_text_x, volume_caption_y), _t("VOLUME"), HORIZONTAL_ALIGNMENT_CENTER, volume_text_width, volume_caption_size, int(maxf(3.0, 4.0 * scale)), Color("#1c1206"))
	draw_string(font, Vector2(volume_text_x, volume_caption_y), _t("VOLUME"), HORIZONTAL_ALIGNMENT_CENTER, volume_text_width, volume_caption_size, Color("#f3e9cf"))
	var volume_text_y: float = volume_down_rect.position.y + volume_down_rect.size.y * 0.68
	var volume_text_size := int(maxf(18.0, 26.0 * scale))
	draw_string_outline(font, Vector2(volume_text_x, volume_text_y), "%d%%" % _settings_volume_percent(), HORIZONTAL_ALIGNMENT_CENTER, volume_text_width, volume_text_size, int(maxf(3.0, 4.0 * scale)), Color("#1c1206"))
	draw_string(font, Vector2(volume_text_x, volume_text_y), "%d%%" % _settings_volume_percent(), HORIZONTAL_ALIGNMENT_CENTER, volume_text_width, volume_text_size, Color("#f3e9cf"))
	_draw_round_button(_ui_press_rect("settings_volume_down", settings_buttons.get("volume_down", Rect2())), "-")
	_draw_round_button(_ui_press_rect("settings_volume_up", settings_buttons.get("volume_up", Rect2())), "+")
	_draw_confirm_button(_ui_press_rect("settings_back", settings_buttons.get("back", Rect2())), _t("BACK"))

func _draw_round_button(rect: Rect2, text: String) -> void:
	if rect.size.x <= 0.0:
		return
	var font := PIXEL_FONT
	var texture_size := Vector2(MENU_ROUND_BUTTON_TEXTURE.get_size())
	var fit_scale := minf(rect.size.x / maxf(texture_size.x, 1.0), rect.size.y / maxf(texture_size.y, 1.0))
	var draw_size := texture_size * fit_scale
	draw_texture_rect(MENU_ROUND_BUTTON_TEXTURE, Rect2(rect.position + (rect.size - draw_size) * 0.5, draw_size), false)
	var font_size := int(maxf(22.0, rect.size.y * 0.52))
	var text_y = rect.position.y + rect.size.y * 0.68
	draw_string_outline(font, Vector2(rect.position.x, text_y), text, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, font_size, int(maxf(3.0, rect.size.y * 0.08)), Color("#3a1206"))
	draw_string(font, Vector2(rect.position.x, text_y), text, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, font_size, Color("#fdf6e3"))

func _settings_language_label() -> String:
	return "CN" if settings_language == "zh" else "EN"

func _is_zh_lang() -> bool:
	return settings_language.begins_with("zh")

func _t(text: String) -> String:
	if settings_language == "zh":
		return String(ZH_TEXTS.get(text, text))
	if settings_language == "zh_hant":
		return String(ZH_HANT_TEXTS.get(text, text))
	return text

func _color_word(color_name: String) -> String:
	if settings_language == "zh":
		return String(COLOR_WORDS_ZH.get(color_name, color_name))
	if settings_language == "zh_hant":
		return String(COLOR_WORDS_ZH_HANT.get(color_name, color_name))
	return color_name.to_upper()

func _special_word(special_kind: String) -> String:
	if settings_language == "zh":
		return String(SPECIAL_WORDS_ZH.get(special_kind, special_kind))
	if settings_language == "zh_hant":
		return String(SPECIAL_WORDS_ZH_HANT.get(special_kind, special_kind))
	return special_kind.to_upper()

func _draw_arena() -> void:
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var bg_inset: float = 40.0 * fc_scale
	var bg_rect := Rect2(Vector2(bg_inset, arena.position.y - 40.0 * fc_scale), Vector2(viewport_size.x - bg_inset * 2.0, arena.size.y + 80.0 * fc_scale))
	draw_texture_rect(ARENA_BG_TEXTURE, bg_rect, false)
	var strip_width: float = WALL_TUBE_WIDTH
	var strip_inset: float = wall_tube_inset - WALL_TUBE_WIDTH
	var segment_height = arena.size.y / 3.0
	for index in range(3):
		var left_rect = Rect2(arena.position + Vector2(strip_inset, segment_height * float(index)), Vector2(strip_width, segment_height))
		var right_rect = Rect2(arena.position + Vector2(arena.size.x - strip_width - strip_inset, segment_height * float(index)), Vector2(strip_width, segment_height))
		draw_texture_rect(TUBE_TEXTURES[LEFT_WALL_COLORS[index]], left_rect, false)
		draw_texture_rect(TUBE_TEXTURES[RIGHT_WALL_COLORS[index]], right_rect, false)
		_draw_wall_flash("left", index, left_rect, LEFT_WALL_COLORS[index])
		_draw_wall_flash("right", index, right_rect, RIGHT_WALL_COLORS[index])
	_draw_frame_console()

func _draw_frame_console() -> void:
	draw_texture_rect_region(FRAME_CONSOLE_TEXTURE, fc_top_rect, Rect2(FC_SRC_X, 0.0, FC_SRC_W, FC_TOP_SRC_H))
	if fc_mid_rect.size.y > 0.5:
		draw_texture_rect_region(FRAME_CONSOLE_TEXTURE, fc_mid_rect, Rect2(FC_SRC_X, FC_MID_SRC_Y, FC_SRC_W, FC_MID_SRC_H))
	draw_texture_rect_region(FRAME_CONSOLE_TEXTURE, fc_bottom_rect, Rect2(FC_SRC_X, FC_BOTTOM_SRC_Y, FC_SRC_W, FC_BOTTOM_SRC_H))
	for color_name in COLOR_ORDER:
		_draw_pipe_cap(color_name)

func _powerup_tag_style_box() -> StyleBoxFlat:
	if powerup_tag_style == null:
		powerup_tag_style = StyleBoxFlat.new()
		powerup_tag_style.bg_color = Color("#22304f")
		powerup_tag_style.set_corner_radius_all(6)
		powerup_tag_style.border_color = Color("#c9a45a")
		powerup_tag_style.set_border_width_all(2)
	return powerup_tag_style

func _cap_mouth_style_box() -> StyleBoxFlat:
	if cap_mouth_style == null:
		cap_mouth_style = StyleBoxFlat.new()
		cap_mouth_style.bg_color = Color("#140d08")
		cap_mouth_style.set_corner_radius_all(5)
		cap_mouth_style.border_color = Color("#2e2013")
		cap_mouth_style.set_border_width_all(2)
	return cap_mouth_style

func _draw_pipe_cap(color_name: String) -> void:
	var openness: float = float(cap_openness.get(color_name, 0.0))
	if openness <= 0.002:
		return
	var src: Rect2 = FC_CAP_SRCS[color_name]
	var screen_pos := Vector2((src.position.x - FC_SRC_X) * fc_scale, fc_bottom_rect.position.y + (src.position.y - FC_BOTTOM_SRC_Y) * fc_scale)
	var screen_size: Vector2 = src.size * fc_scale
	var mouth_rect := Rect2(screen_pos - Vector2(1.0, 1.0), screen_size + Vector2(2.0, 2.0))
	draw_style_box(_cap_mouth_style_box(), mouth_rect)
	var visible_fraction: float = 1.0 - openness
	if visible_fraction <= 0.01:
		return
	var visible_src := Rect2(Vector2(src.position.x + src.size.x * openness, src.position.y), Vector2(src.size.x * visible_fraction, src.size.y))
	draw_texture_rect_region(FRAME_CONSOLE_TEXTURE, Rect2(screen_pos, Vector2(screen_size.x * visible_fraction, screen_size.y)), visible_src)

func _glow_texture() -> Texture2D:
	if glow_gradient_texture == null:
		var gradient := Gradient.new()
		gradient.offsets = PackedFloat32Array([0.0, 0.35, 0.68, 1.0])
		gradient.colors = PackedColorArray([
			Color(1.0, 1.0, 1.0, 1.0),
			Color(1.0, 1.0, 1.0, 0.62),
			Color(1.0, 1.0, 1.0, 0.20),
			Color(1.0, 1.0, 1.0, 0.0),
		])
		glow_gradient_texture = GradientTexture2D.new()
		glow_gradient_texture.gradient = gradient
		glow_gradient_texture.fill = GradientTexture2D.FILL_RADIAL
		glow_gradient_texture.fill_from = Vector2(0.5, 0.5)
		glow_gradient_texture.fill_to = Vector2(0.5, 0.0)
		glow_gradient_texture.width = 128
		glow_gradient_texture.height = 128
	return glow_gradient_texture

func _draw_wall_flash(side: String, segment: int, tube_rect: Rect2, color_name: String) -> void:
	var timer: float = float(wall_flash_timers.get("%s_%d" % [side, segment], 0.0))
	if timer <= 0.0:
		return
	var strength: float = clampf(timer / WALL_FLASH_SECONDS, 0.0, 1.0)
	strength *= 0.78 + 0.22 * sin(effects_anim_time * 42.0)
	var glow := _glow_texture()
	var center_x: float = tube_rect.position.x + tube_rect.size.x * 0.5
	var glass_top: float = tube_rect.position.y + tube_rect.size.y * 0.14
	var glass_length: float = tube_rect.size.y * 0.72
	var tube_width: float = tube_rect.size.x
	var base: Color = COLOR_VALUES[color_name]
	var halo := base.lightened(0.25)
	halo.a = 0.34 * strength
	var halo_rect := Rect2(Vector2(center_x - tube_width * 2.1, glass_top - tube_width * 1.2), Vector2(tube_width * 4.2, glass_length + tube_width * 2.4))
	draw_texture_rect(glow, halo_rect, false, halo)
	var body := base.lightened(0.55)
	body.a = 0.72 * strength
	var body_rect := Rect2(Vector2(center_x - tube_width * 0.95, glass_top - tube_width * 0.3), Vector2(tube_width * 1.9, glass_length + tube_width * 0.6))
	draw_texture_rect(glow, body_rect, false, body)
	var core := Color(1.0, 1.0, 1.0, 0.8 * strength)
	var core_rect := Rect2(Vector2(center_x - tube_width * 0.45, glass_top + glass_length * 0.08), Vector2(tube_width * 0.9, glass_length * 0.84))
	draw_texture_rect(glow, core_rect, false, core)

func _draw_top_hud() -> void:
	var viewport_size := get_viewport_rect().size
	var scale = minf(viewport_size.x / 540.0, viewport_size.y / 960.0)
	var font := PIXEL_FONT
	var badge_size: float = 126.0 * scale
	var badge_rect := Rect2(Vector2((viewport_size.x - badge_size) * 0.5, 44.0 * scale), Vector2(badge_size, badge_size))
	draw_texture_rect(BADGE_TEXTURE, badge_rect, false)
	var level_text := str(current_level)
	var badge_font := int(badge_size * 0.40)
	var badge_text_y: float = badge_rect.position.y + badge_size * 0.5 + badge_font * 0.36
	draw_string_outline(font, Vector2(badge_rect.position.x, badge_text_y), level_text, HORIZONTAL_ALIGNMENT_CENTER, badge_size, badge_font, int(maxf(3.0, 5.0 * scale)), Color("#06240e"))
	draw_string(font, Vector2(badge_rect.position.x, badge_text_y), level_text, HORIZONTAL_ALIGNMENT_CENTER, badge_size, badge_font, Color.WHITE)
	var badge_center_y: float = badge_rect.position.y + badge_size * 0.5
	var coins_value := _displayed_level_complete_coin_total() if level_complete else coin_count
	var coin_text := str(coins_value)
	var coin_plaque := Rect2(Vector2(viewport_size.x - 172.0 * scale, badge_center_y - 23.0 * scale), Vector2(160.0 * scale, 46.0 * scale))
	draw_texture_rect(PLAQUE_INFO_TEXTURE, coin_plaque, false)
	var coin_font := int(maxf(20.0, 26.0 * scale))
	var coin_icon_radius: float = 12.0 * scale
	var coin_gap: float = 10.0 * scale
	while coin_font > 12 and font.get_string_size(coin_text, HORIZONTAL_ALIGNMENT_LEFT, -1, coin_font).x + coin_icon_radius * 2.0 + coin_gap > coin_plaque.size.x * 0.66:
		coin_font -= 1
	var coin_text_width: float = font.get_string_size(coin_text, HORIZONTAL_ALIGNMENT_LEFT, -1, coin_font).x
	var coin_group_width: float = coin_icon_radius * 2.0 + coin_gap + coin_text_width
	var coin_group_x: float = coin_plaque.position.x + (coin_plaque.size.x - coin_group_width) * 0.5
	var coin_center_y: float = coin_plaque.position.y + coin_plaque.size.y * 0.5
	var coin_text_y: float = coin_center_y + coin_font * 0.36
	_draw_coin_icon(Vector2(coin_group_x + coin_icon_radius, coin_center_y), coin_icon_radius, 1.0)
	var coin_text_x: float = coin_group_x + coin_icon_radius * 2.0 + coin_gap
	draw_string_outline(font, Vector2(coin_text_x, coin_text_y), coin_text, HORIZONTAL_ALIGNMENT_LEFT, coin_text_width + 8.0, coin_font, int(maxf(3.0, 4.0 * scale)), Color("#1c1206"))
	draw_string(font, Vector2(coin_text_x, coin_text_y), coin_text, HORIZONTAL_ALIGNMENT_LEFT, coin_text_width + 8.0, coin_font, Color("#ffd27a"))
	var plaque_width: float = minf(570.0 * scale, viewport_size.x - 24.0 * scale)
	var plaque_rect := Rect2(Vector2((viewport_size.x - plaque_width) * 0.5, 176.0 * scale), Vector2(plaque_width, 99.0 * scale))
	draw_texture_rect(PLAQUE_TEXTURE, plaque_rect, false)
	var hud_text_width: float = plaque_rect.size.x * 0.58
	var hud_text_y: float = plaque_rect.position.y + plaque_rect.size.y * 0.62
	if settings_language == "en":
		var hud_groups := [
			["target", str(_remaining_target_count())],
			["shot", "%d/%d" % [shots_used, shot_limit]],
			["star", str(level_perfect_hits)],
		]
		var icon_font := int(maxf(22.0, 32.0 * scale))
		while icon_font > 12 and _hud_icon_groups_width(font, hud_groups, icon_font) > hud_text_width - 4.0:
			icon_font -= 1
		var group_x: float = plaque_rect.position.x + (plaque_rect.size.x - _hud_icon_groups_width(font, hud_groups, icon_font)) * 0.5
		_draw_hud_icon_groups(font, Vector2(group_x, hud_text_y), hud_groups, icon_font)
		return
	var hud_segments := [
		[_t("T:"), false], [" ", false], [str(_remaining_target_count()), true],
		["   ", false], [_t("S:"), false], [" ", false], ["%d/%d" % [shots_used, shot_limit], true],
		["   ", false], [_t("P:"), false], [" ", false], [str(level_perfect_hits), true],
	]
	var hud_font := int(maxf(22.0, 32.0 * scale))
	while hud_font > 12 and _segments_width(font, hud_segments, hud_font) > hud_text_width - 4.0:
		hud_font -= 1
	var hud_x: float = plaque_rect.position.x + (plaque_rect.size.x - _segments_width(font, hud_segments, hud_font)) * 0.5
	_draw_text_segments(font, Vector2(hud_x, hud_text_y), hud_segments, hud_font)

func _segments_width(font: Font, segments: Array, font_size: int) -> float:
	var total := 0.0
	for segment in segments:
		total += font.get_string_size(String(segment[0]), HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
	return total

func _hud_icon_slot_width(_kind: String, font_size: int) -> float:
	return font_size * 0.42 * 2.0

func _hud_icon_groups_width(font: Font, groups: Array, font_size: int) -> float:
	var icon_gap: float = font_size * 0.38
	var group_gap: float = font_size * 1.1
	var total := 0.0
	for index in groups.size():
		total += _hud_icon_slot_width(String(groups[index][0]), font_size) + icon_gap
		total += font.get_string_size(String(groups[index][1]), HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
		if index < groups.size() - 1:
			total += group_gap
	return total

func _draw_hud_icon_groups(font: Font, at: Vector2, groups: Array, font_size: int) -> void:
	var icon_radius: float = font_size * 0.42
	var icon_gap: float = font_size * 0.38
	var group_gap: float = font_size * 1.1
	var center_y: float = at.y - font_size * 0.36
	var x := at.x
	for index in groups.size():
		var kind := String(groups[index][0])
		var slot_width := _hud_icon_slot_width(kind, font_size)
		var icon_center := Vector2(x + slot_width - icon_radius, center_y)
		match kind:
			"target":
				_draw_hud_target_icon(icon_center, icon_radius)
			"shot":
				_draw_hud_shot_icon(icon_center, icon_radius)
			"star":
				_draw_hud_star_icon(icon_center, icon_radius)
		x += slot_width + icon_gap
		var value := String(groups[index][1])
		var value_width: float = font.get_string_size(value, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
		draw_string(font, Vector2(x, at.y), value, HORIZONTAL_ALIGNMENT_LEFT, value_width + 8.0, font_size, STAT_NUMBER_COLOR)
		x += value_width + group_gap

func _draw_hud_target_icon(center: Vector2, radius: float) -> void:
	draw_circle(center, radius, Color("#f3e9cf"))
	draw_circle(center, radius * 0.64, Color("#22304f"))
	draw_circle(center, radius * 0.30, Color("#e2493b"))

func _draw_hud_shot_icon(center: Vector2, radius: float) -> void:
	var texture_size := Vector2(HUD_SHOT_ICON_TEXTURE.get_size())
	var box: float = radius * 2.5
	var fit: float = minf(box / maxf(texture_size.x, 1.0), box / maxf(texture_size.y, 1.0))
	var draw_size := texture_size * fit
	draw_texture_rect(HUD_SHOT_ICON_TEXTURE, Rect2(center - draw_size * 0.5, draw_size), false)

func _draw_hud_star_icon(center: Vector2, radius: float) -> void:
	var points := PackedVector2Array()
	for index in range(10):
		var angle := -PI / 2.0 + float(index) * PI / 5.0
		var point_radius := radius * 1.05 if index % 2 == 0 else radius * 0.46
		points.append(center + Vector2(cos(angle), sin(angle)) * point_radius)
	draw_colored_polygon(points, Color("#ffd24a"))

func _draw_text_segments(font: Font, at: Vector2, segments: Array, font_size: int) -> void:
	var x := at.x
	for segment in segments:
		var segment_text := String(segment[0])
		var segment_width: float = font.get_string_size(segment_text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
		var segment_color := STAT_NUMBER_COLOR if bool(segment[1]) else Color("#f3e9cf")
		draw_string(font, Vector2(x, at.y), segment_text, HORIZONTAL_ALIGNMENT_LEFT, segment_width + 8.0, font_size, segment_color)
		x += segment_width

func _draw_black_hole() -> void:
	if not black_hole_active:
		return
	var radius := BLACK_HOLE_RADIUS
	var spin := effects_anim_time * 0.7
	var pulse := 1.0 + 0.05 * sin(effects_anim_time * 2.1)
	var draw_radius := radius * 1.25 * pulse
	draw_circle(black_hole_position, radius * 0.72, Color("#050505"))
	draw_set_transform(black_hole_position, spin, Vector2.ONE)
	draw_texture_rect(BLACK_HOLE_TEXTURE, Rect2(Vector2(-draw_radius, -draw_radius), Vector2(draw_radius * 2.0, draw_radius * 2.0)), false)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)

func _draw_balls() -> void:
	for ball in balls:
		var color: Color = COLOR_VALUES[ball.color_name]
		if ball.is_target:
			var target_texture: Texture2D = BALL_TEXTURES.get(ball.color_name)
			if target_texture != null:
				_draw_textured_orb(target_texture, ball.position, ball.radius + 2.2, ball.spin_angle, TARGET_BALL_TINT)
				_draw_glass_orb_fx(ball.position, ball.radius + 2.2)
			else:
				draw_circle(ball.position, ball.radius + 2.2, Color.BLACK)
				draw_circle(ball.position, ball.radius, color)
			if ball.merged_target:
				_draw_merged_target_spikes(ball)
			if _level_has_target_hp():
				_draw_target_hp(ball)
		else:
			if ball.is_furball:
				_draw_furball(ball)
			elif ball.special_kind == "crystal":
				_draw_crystal_ball(ball)
			elif ball.special_kind == "antimatter":
				_draw_antimatter_ball(ball)
			elif ball.special_kind == "missile":
				_draw_missile_ball(ball)
			else:
				var launcher_texture: Texture2D = BALL_TEXTURES.get(ball.color_name)
				if launcher_texture != null:
					_draw_metal_orb_halo(ball.position, ball.radius + 2.0, color)
					_draw_textured_orb(launcher_texture, ball.position, ball.radius + 2.0, ball.spin_angle, PLAYER_BALL_TINT)
					_draw_metal_orb_fx(ball.position, ball.radius + 2.0)
				else:
					draw_circle(ball.position, ball.radius + 2.0, color.lightened(0.22))
					draw_circle(ball.position, ball.radius, color)

func _draw_textured_orb(texture: Texture2D, center: Vector2, draw_radius: float, rotation: float, tint := Color.WHITE) -> void:
	draw_set_transform(center, rotation, Vector2.ONE)
	draw_texture_rect(texture, Rect2(Vector2(-draw_radius, -draw_radius), Vector2(draw_radius * 2.0, draw_radius * 2.0)), false, tint)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)

func _draw_metal_orb_halo(center: Vector2, radius: float, base_color: Color) -> void:
	var halo := base_color.lightened(0.35)
	halo.a = 0.30
	draw_texture_rect(_glow_texture(), Rect2(center - Vector2(radius * 1.9, radius * 1.9), Vector2(radius * 3.8, radius * 3.8)), false, halo)

func _draw_metal_orb_fx(center: Vector2, radius: float) -> void:
	var glint_center := center + Vector2(-radius * 0.38, -radius * 0.44)
	draw_texture_rect(_glow_texture(), Rect2(glint_center - Vector2(radius * 0.42, radius * 0.42), Vector2(radius * 0.84, radius * 0.84)), false, Color(1.0, 1.0, 1.0, 0.80))
	draw_circle(glint_center, radius * 0.10, Color(1.0, 1.0, 1.0, 0.95))
	draw_arc(center, radius * 0.84, 0.30, 1.35, 18, Color(1.0, 0.95, 0.80, 0.38), maxf(1.5, radius * 0.10))

func _draw_glass_orb_fx(center: Vector2, radius: float) -> void:
	var glow := _glow_texture()
	var sheen_center := center + Vector2(-radius * 0.32, -radius * 0.40)
	var sheen_size := Vector2(radius * 1.05, radius * 0.78)
	draw_texture_rect(glow, Rect2(sheen_center - sheen_size * 0.5, sheen_size), false, Color(1.0, 1.0, 1.0, 0.30))
	var rim_center := center + Vector2(radius * 0.18, radius * 0.55)
	var rim_size := Vector2(radius * 0.85, radius * 0.38)
	draw_texture_rect(glow, Rect2(rim_center - rim_size * 0.5, rim_size), false, Color(0.75, 0.90, 1.0, 0.15))

func _draw_merged_target_spikes(ball: GameBall) -> void:
	var extension := _spike_extension(ball)
	if extension <= 0.02 or ball.spike_count <= 0:
		return
	var spike_length := ball.radius * 0.60 * extension
	var base_half_width := ball.radius * 0.15
	for index in range(ball.spike_count):
		var angle := ball.spin_angle + TAU * float(index) / float(ball.spike_count)
		var direction := Vector2.RIGHT.rotated(angle)
		var normal := direction.orthogonal()
		var base_center: Vector2 = ball.position + direction * (ball.radius * 0.90)
		var tip: Vector2 = base_center + direction * spike_length
		var p1: Vector2 = base_center + normal * base_half_width
		var p2: Vector2 = base_center - normal * base_half_width
		draw_colored_polygon(PackedVector2Array([p1, tip, p2]), Color("#c9ced4"))
		draw_line(p1, tip, Color("#f2f5f8"), 1.6, true)
		draw_line(p2, tip, Color("#565c63"), 1.6, true)
		draw_circle(base_center, base_half_width * 0.85, Color("#9aa1a8"))

func _draw_furball(ball: GameBall) -> void:
	_draw_furball_body(ball.position, ball.radius, ball.spin_angle)
	var remaining := int(ceilf(PINK_FURBALL_LIFETIME if ball.furball_life < 0.0 else ball.furball_life))
	var font := PIXEL_FONT
	var font_size := int(maxf(12.0, ball.radius * 0.85))
	draw_string(font, ball.position + Vector2(-ball.radius, font_size * 0.36), str(remaining), HORIZONTAL_ALIGNMENT_CENTER, ball.radius * 2.0, font_size, Color("#7a1040"))

func _draw_furball_body(center: Vector2, radius: float, rotation: float) -> void:
	var glow_pulse := 0.32 + 0.14 * sin(effects_anim_time * 4.2)
	draw_texture_rect(_glow_texture(), Rect2(center - Vector2(radius * 2.2, radius * 2.2), Vector2(radius * 4.4, radius * 4.4)), false, Color(1.0, 0.62, 0.80, glow_pulse))
	_draw_textured_orb(FURBALL_TEXTURE, center, radius * FURBALL_TEXTURE_SCALE, rotation)
	for sparkle in range(6):
		var seed := float(sparkle)
		var sparkle_angle := rotation + seed * 2.399
		var sparkle_dist := radius * (0.30 + 0.62 * fposmod(seed * 0.731 + 0.19, 1.0))
		var sparkle_pos := center + Vector2(cos(sparkle_angle), sin(sparkle_angle)) * sparkle_dist
		var twinkle := 0.5 + 0.5 * sin(effects_anim_time * (6.0 + seed * 1.3) + seed * 2.1)
		if twinkle < 0.25:
			continue
		var sparkle_alpha := twinkle * twinkle * 0.95
		var ray := radius * (0.16 + 0.20 * twinkle)
		var sparkle_color := Color(1.0, 0.97, 1.0, sparkle_alpha)
		draw_line(sparkle_pos + Vector2(-ray, 0.0), sparkle_pos + Vector2(ray, 0.0), sparkle_color, maxf(1.2, radius * 0.05), true)
		draw_line(sparkle_pos + Vector2(0.0, -ray), sparkle_pos + Vector2(0.0, ray), sparkle_color, maxf(1.2, radius * 0.05), true)
		draw_circle(sparkle_pos, radius * 0.07, sparkle_color)
		draw_texture_rect(_glow_texture(), Rect2(sparkle_pos - Vector2(ray, ray), Vector2(ray * 2.0, ray * 2.0)), false, Color(1.0, 0.80, 0.92, sparkle_alpha * 0.5))
	var glint_center := center + Vector2(-radius * 0.34, -radius * 0.38)
	draw_texture_rect(_glow_texture(), Rect2(glint_center - Vector2(radius * 0.5, radius * 0.5), Vector2(radius, radius)), false, Color(1.0, 0.94, 0.98, 0.55))

func _draw_crystal_ball(ball: GameBall) -> void:
	draw_circle(ball.position, ball.radius + 5.2, Color(0.86, 1.0, 1.0, 0.84))
	_draw_textured_orb(BALL_TEXTURES["crystal"], ball.position, ball.radius + 1.8, ball.spin_angle)
	var font := PIXEL_FONT
	draw_string(font, ball.position + Vector2(-ball.radius, ball.radius * 0.42), str(ball.special_hp), HORIZONTAL_ALIGNMENT_CENTER, ball.radius * 2.0, int(ball.radius * 0.78), Color("#1b5961"))

func _draw_antimatter_ball(ball: GameBall) -> void:
	draw_circle(ball.position, ball.radius + 4.8, Color(0.42, 0.24, 0.62, 0.55))
	_draw_textured_orb(BALL_TEXTURES["dark"], ball.position, ball.radius + 1.8, ball.spin_angle)

func _draw_missile_ball(ball: GameBall) -> void:
	var base_color: Color = COLOR_VALUES.get(ball.color_name, Color("#ff8f2a"))
	var direction := Vector2.UP
	if ball.velocity.length_squared() > 0.001:
		direction = ball.velocity.normalized()
	var angle := direction.angle() + PI * 0.5
	var flicker := 0.85 + 0.30 * sin(effects_anim_time * 26.0 + ball.position.x * 0.05)
	var texture_size := Vector2(MISSILE_BALL_TEXTURE.get_size())
	var missile_length: float = ball.radius * 3.2
	var missile_width: float = missile_length * texture_size.x / maxf(texture_size.y, 1.0)
	var tint := Color.WHITE.lerp(base_color, 0.30)
	draw_set_transform(ball.position, angle, Vector2.ONE)
	var exhaust_size: float = missile_width * (0.9 + 0.35 * flicker)
	draw_texture_rect(_glow_texture(), Rect2(Vector2(-exhaust_size * 0.5, missile_length * 0.30), Vector2(exhaust_size, exhaust_size)), false, Color(1.0, 0.60, 0.16, 0.70 * flicker))
	draw_texture_rect(MISSILE_BALL_TEXTURE, Rect2(Vector2(-missile_width * 0.5, -missile_length * 0.5), Vector2(missile_width, missile_length)), false, tint)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	draw_texture_rect(_glow_texture(), Rect2(ball.position - Vector2(ball.radius * 1.5, ball.radius * 1.5), Vector2(ball.radius * 3.0, ball.radius * 3.0)), false, Color(base_color.r, base_color.g, base_color.b, 0.18))

func _draw_target_hp(ball: GameBall) -> void:
	draw_circle(ball.position, ball.radius * 0.48, Color(0.0, 0.0, 0.0, 0.50))
	var font := PIXEL_FONT
	var font_size := int(maxf(13.0, ball.radius * 0.92))
	var text := str(ball.hp)
	var text_position = ball.position + Vector2(-ball.radius, font_size * 0.34)
	draw_string(font, text_position, text, HORIZONTAL_ALIGNMENT_CENTER, ball.radius * 2.0, font_size, Color.WHITE)

func _draw_particles() -> void:
	for particle in particles:
		var alpha = clampf(particle.life / particle.max_life, 0.0, 1.0)
		var color = particle.color
		color.a *= alpha
		if particle.kind == "spark":
			var streak_end = particle.position - particle.velocity * 0.05
			draw_line(particle.position, streak_end, color, maxf(1.4, particle.radius), true)
			var core_color = color.lerp(Color.WHITE, 0.65)
			core_color.a = color.a
			draw_line(particle.position, particle.position - particle.velocity * 0.022, core_color, maxf(1.0, particle.radius * 0.6), true)
		elif particle.kind == "ember":
			var flicker := 0.72 + 0.28 * sin(effects_anim_time * 31.0 + particle.position.x * 0.11)
			var ember_color = color
			ember_color.a *= flicker
			var glow_color := Color(ember_color.r, ember_color.g, ember_color.b, ember_color.a * 0.5)
			draw_texture_rect(_glow_texture(), Rect2(particle.position - Vector2(particle.radius * 3.0, particle.radius * 3.0), Vector2(particle.radius * 6.0, particle.radius * 6.0)), false, glow_color)
			draw_circle(particle.position, particle.radius * (0.7 + 0.3 * flicker), ember_color)
		elif particle.kind == "flash":
			var flash_radius = particle.radius * (0.55 + 0.65 * (1.0 - alpha))
			draw_texture_rect(_glow_texture(), Rect2(particle.position - Vector2(flash_radius, flash_radius), Vector2(flash_radius * 2.0, flash_radius * 2.0)), false, color)
		elif particle.kind == "ring":
			var ring_progress = 1.0 - alpha
			var ring_radius = particle.radius * (0.35 + 0.65 * ring_progress)
			draw_arc(particle.position, ring_radius, 0.0, TAU, 40, color, maxf(1.5, 3.5 * alpha))
		else:
			draw_circle(particle.position, particle.radius * alpha, color)

func _draw_launcher() -> void:
	for color_name in COLOR_ORDER:
		_draw_launcher_button(color_name)

func _launcher_ball_pulled(color_name: String) -> bool:
	if drag_active and drag_color == color_name:
		return true
	for key in mix_touch_drags.keys():
		var entry: Dictionary = mix_touch_drags[key]
		if String(entry.get("color", "")) == color_name and not bool(entry.get("released", false)):
			return true
	return false

func _draw_launcher_button(color_name: String) -> void:
	var center: Vector2 = _button_center(color_name)
	var radius: float = button_radius * 0.78
	var pressed: bool = drag_active and drag_color == color_name
	if _launcher_ball_pulled(color_name):
		draw_circle(center, radius * 0.96, Color(0.04, 0.03, 0.02, 0.45))
		return
	var draw_center: Vector2 = center + (Vector2(0.0, radius * 0.10) if pressed else Vector2.ZERO)
	var button_color: Color = COLOR_VALUES[color_name]
	draw_circle(center + Vector2(0.0, radius * 0.13), radius * (1.03 if pressed else 0.98), Color(0.0, 0.0, 0.0, 0.28 if pressed else 0.14))
	var button_texture: Texture2D = BALL_TEXTURES.get(color_name)
	if button_texture != null:
		_draw_textured_orb(button_texture, draw_center, radius * (0.92 if pressed else 1.0), 0.0)
	else:
		draw_circle(draw_center, radius * (0.92 if pressed else 1.0), button_color)
	if pressed:
		draw_arc(draw_center, radius * 1.03, 0.0, TAU, 36, Color("#111111"), maxf(2.0, radius * 0.06))

func _draw_launcher_bands() -> void:
	for key in mix_touch_drags.keys():
		var entry: Dictionary = mix_touch_drags[key]
		var color_name := String(entry.get("color", ""))
		var position: Vector2 = entry.get("position", Vector2.ZERO)
		_draw_launcher_band(color_name, position, _launch_tension_for_color(color_name, position), bool(entry.get("released", false)))
		if not bool(entry.get("released", false)):
			_draw_aimer_guide(color_name, position)
	if not drag_active or drag_color == "":
		return
	if drag_mix_locked:
		_draw_locked_mix_launch()
		_draw_mix_connection_dots()
		return
	_draw_launcher_band(drag_color, drag_position, _launch_tension(), false)
	_draw_mix_connection_dots()
	_draw_aimer_guide(drag_color, drag_position)

func _draw_mix_connection_dots() -> void:
	if not drag_active or drag_color == "":
		return
	if not _level_has_color_mixing():
		return
	var from := Vector2.ZERO
	var to := Vector2.ZERO
	if drag_mix_locked:
		# Locked but finger still resting on the second ball: keep the line
		# until the player pulls down to aim.
		if _launch_tension() > 0.02:
			return
		from = _button_center(drag_mix_first_color)
		to = drag_position
	else:
		if not _is_primary_color(drag_color):
			return
		if not _drag_gesture_is_horizontal():
			return
		var best_color := ""
		var best_distance := INF
		for color_name in COLOR_ORDER:
			if color_name == drag_color:
				continue
			if _mixed_color_for_pair(drag_color, color_name) == "":
				continue
			var distance := drag_raw_position.distance_to(_button_center(color_name))
			if distance < best_distance:
				best_distance = distance
				best_color = color_name
		if best_color == "":
			return
		from = drag_position
		to = _button_center(best_color)
	var span := to - from
	var length := span.length()
	var start_offset := button_radius * 0.55
	var end_offset := button_radius * 0.75
	var usable := length - start_offset - end_offset
	if usable <= 8.0:
		return
	var direction := span / length
	var dot_count := maxi(int(usable / 12.0), 2)
	for index in range(dot_count + 1):
		var t := float(index) / float(dot_count)
		var dot_pos := from + direction * (start_offset + usable * t)
		var shimmer := 0.55 + 0.45 * sin(effects_anim_time * 6.0 - t * TAU)
		draw_circle(dot_pos, 4.4, Color(0.10, 0.08, 0.05, 0.30 * shimmer))
		draw_circle(dot_pos, 3.0, Color(1.0, 1.0, 1.0, 0.85 * shimmer))

func _draw_locked_mix_launch() -> void:
	var mixed_color := drag_mix_result_color
	if mixed_color == "":
		return
	var tension := _launch_tension()
	var center := _button_center(drag_color)
	var radius := button_radius * 0.78
	var mix_value: Color = COLOR_VALUES[mixed_color]
	var accent := Color("#6b4a20").lerp(mix_value, 0.35 + tension * 0.55)
	var band_width = lerpf(4.0, 9.0, tension)
	_draw_band_strap(center + Vector2(-radius * 0.68, -radius * 0.42), drag_position, band_width, accent, 1.0)
	_draw_band_strap(center + Vector2(radius * 0.68, -radius * 0.42), drag_position, band_width, accent, 1.0)
	if tension >= 0.999:
		_draw_charge_ripples(drag_position, LAUNCH_RADIUS, mix_value)
	draw_circle(drag_position, band_width * 1.7, Color(0.16, 0.10, 0.05))
	draw_circle(drag_position, band_width * 1.25, Color(0.42, 0.28, 0.13))
	draw_circle(drag_position, band_width * 0.55, accent.lightened(0.15))
	var staged := Vector2(center.x, arena.position.y + arena.size.y - LAUNCH_RADIUS - 4.0)
	var pulse := 0.5 + 0.5 * sin(effects_anim_time * 8.0)
	var halo := mix_value.lightened(0.30)
	halo.a = 0.30 + 0.35 * pulse
	draw_texture_rect(_glow_texture(), Rect2(staged - Vector2(LAUNCH_RADIUS * 2.6, LAUNCH_RADIUS * 2.6), Vector2(LAUNCH_RADIUS * 5.2, LAUNCH_RADIUS * 5.2)), false, halo)
	var staged_radius := LAUNCH_RADIUS * (1.04 + 0.10 * pulse)
	var staged_texture: Texture2D = BALL_TEXTURES.get(mixed_color)
	if staged_texture != null:
		_draw_metal_orb_halo(staged, staged_radius, mix_value)
		_draw_textured_orb(staged_texture, staged, staged_radius, effects_anim_time * 1.6, PLAYER_BALL_TINT)
		_draw_metal_orb_fx(staged, staged_radius)
	else:
		draw_circle(staged, staged_radius, mix_value)
	for index in range(4):
		var sparkle_angle := effects_anim_time * 2.4 + float(index) * TAU / 4.0
		var sparkle_pos := staged + Vector2(cos(sparkle_angle), sin(sparkle_angle)) * staged_radius * 1.45
		var sparkle_alpha := 0.35 + 0.65 * (0.5 + 0.5 * sin(effects_anim_time * 9.0 + float(index) * 1.7))
		var ray := staged_radius * 0.42 * (0.6 + 0.4 * sparkle_alpha)
		var sparkle_color := Color(1.0, 1.0, 1.0, sparkle_alpha)
		draw_line(sparkle_pos + Vector2(-ray, 0.0), sparkle_pos + Vector2(ray, 0.0), sparkle_color, 1.6, true)
		draw_line(sparkle_pos + Vector2(0.0, -ray), sparkle_pos + Vector2(0.0, ray), sparkle_color, 1.6, true)
		draw_circle(sparkle_pos, staged_radius * 0.10, sparkle_color)
	if aimer_armed and aimer_charges > 0:
		_draw_aimer_guide(drag_color, drag_position)
	elif tension > 0.02:
		_draw_mix_aim_guide(drag_color, drag_position, mix_value)

func _draw_mix_aim_guide(anchor_color: String, pull_position: Vector2, mix_color: Color) -> void:
	var direction := _launch_direction_for_color(anchor_color, pull_position)
	var center: Vector2 = _button_center(anchor_color)
	var origin := Vector2(center.x, arena.position.y + arena.size.y - LAUNCH_RADIUS - 4.0)
	var guide_length := LAUNCH_RADIUS * 2.67
	var dot_count := 6
	var bright := mix_color.lightened(0.35)
	for index in range(dot_count):
		var t := float(index) / float(dot_count - 1)
		var dot_position: Vector2 = origin + direction * (LAUNCH_RADIUS * 1.4 + guide_length * t)
		var dot_radius: float = lerpf(5.6, 2.2, t)
		var shimmer := 0.5 + 0.5 * sin(effects_anim_time * 7.0 - t * TAU * 1.3)
		draw_circle(dot_position, dot_radius * 1.5, Color(0.10, 0.08, 0.05, 0.35))
		draw_circle(dot_position, dot_radius * 1.9, Color(bright.r, bright.g, bright.b, 0.10 + 0.10 * shimmer))
		draw_circle(dot_position, dot_radius, Color(bright.r, bright.g, bright.b, 0.72 + 0.28 * shimmer))

func _draw_aimer_guide(color_name: String, pull_position: Vector2) -> void:
	if not aimer_armed or aimer_charges <= 0 or color_name == "":
		return
	var direction := _launch_direction_for_color(color_name, pull_position)
	var center: Vector2 = _button_center(color_name)
	var origin := Vector2(center.x, arena.position.y + arena.size.y - LAUNCH_RADIUS - 4.0)
	var guide_length := LAUNCH_RADIUS * 5.33
	var dot_count := 10
	for index in range(dot_count):
		var t := float(index) / float(dot_count - 1)
		var dot_position: Vector2 = origin + direction * (LAUNCH_RADIUS * 1.4 + guide_length * t)
		var dot_radius: float = lerpf(6.4, 2.4, t)
		var shimmer := 0.5 + 0.5 * sin(effects_anim_time * 7.0 - t * TAU * 1.3)
		draw_circle(dot_position, dot_radius * 1.55, Color(0.10, 0.08, 0.05, 0.40))
		draw_circle(dot_position, dot_radius * 2.0, Color(1.0, 1.0, 1.0, 0.08 + 0.10 * shimmer))
		draw_circle(dot_position, dot_radius, Color(1.0, 1.0, 1.0, 0.78 + 0.22 * shimmer))
		for speck in range(5):
			var seed := float(index * 7 + speck * 13)
			var speck_angle := seed * 2.399
			var speck_dist := dot_radius * (0.65 + 0.55 * fposmod(seed * 0.731, 1.0))
			var speck_position := dot_position + Vector2(cos(speck_angle), sin(speck_angle)) * speck_dist
			var speck_alpha := 0.30 + 0.60 * (0.5 + 0.5 * sin(effects_anim_time * 9.0 + seed))
			draw_circle(speck_position, dot_radius * 0.30, Color(1.0, 1.0, 1.0, speck_alpha))

func _draw_launcher_band(color_name: String, position: Vector2, tension: float, released: bool) -> void:
	if color_name == "":
		return
	var center = _button_center(color_name)
	var radius = button_radius * 0.78
	var band_width = lerpf(4.0, 9.0, tension)
	var band_alpha := 0.55 if released else 1.0
	var accent := Color("#6b4a20").lerp(COLOR_VALUES[color_name], tension * 0.8)
	var left_anchor = center + Vector2(-radius * 0.68, -radius * 0.42)
	var right_anchor = center + Vector2(radius * 0.68, -radius * 0.42)

	_draw_band_strap(left_anchor, position, band_width, accent, band_alpha)
	_draw_band_strap(right_anchor, position, band_width, accent, band_alpha)
	var pull_radius := LAUNCH_RADIUS * lerpf(0.92, 1.10, tension)
	var pull_texture: Texture2D = BALL_TEXTURES.get(color_name)
	if tension >= 0.999 and not released:
		_draw_charge_ripples(position, pull_radius, COLOR_VALUES[color_name])
	if pull_texture != null:
		_draw_metal_orb_halo(position, pull_radius, COLOR_VALUES[color_name])
		_draw_textured_orb(pull_texture, position, pull_radius, 0.0, PLAYER_BALL_TINT)
		_draw_metal_orb_fx(position, pull_radius)
	else:
		draw_circle(position, pull_radius, COLOR_VALUES[color_name])

func _draw_charge_ripples(center: Vector2, base_radius: float, color: Color) -> void:
	var ripple_count := 3
	for index in range(ripple_count):
		var phase := fposmod(effects_anim_time * 1.4 + float(index) / float(ripple_count), 1.0)
		var ripple_radius := base_radius * lerpf(1.2, 3.4, phase)
		var ripple_color := color.lightened(0.45)
		ripple_color.a = (1.0 - phase) * (1.0 - phase) * 0.85
		if ripple_color.a <= 0.02:
			continue
		var ripple_width := maxf(1.6, base_radius * 0.14 * (1.0 - phase * 0.6))
		draw_arc(center, ripple_radius, 0.0, TAU, 44, ripple_color, ripple_width, true)

func _draw_band_strap(anchor: Vector2, pull_position: Vector2, width: float, accent: Color, alpha: float) -> void:
	var outline := Color(0.16, 0.10, 0.05, alpha)
	var leather := Color(0.42, 0.28, 0.13, alpha)
	var core := accent.lightened(0.12)
	core.a = alpha
	draw_line(anchor, pull_position, outline, width + 3.0, true)
	draw_line(anchor, pull_position, leather, width, true)
	draw_line(anchor, pull_position, core, maxf(1.6, width * 0.42), true)
	draw_circle(anchor, maxf(3.2, width * 0.60), Color(0.79, 0.63, 0.35, alpha))
	draw_circle(anchor, maxf(1.8, width * 0.32), Color(0.50, 0.37, 0.18, alpha))
	draw_arc(position, LAUNCH_RADIUS * 1.12, 0.0, TAU, 32, Color.BLACK, 2.0)

func _is_primary_color(color_name: String) -> bool:
	return COLOR_ORDER.has(color_name)

func _is_mixed_color(color_name: String) -> bool:
	return MIXED_COLOR_ORDER.has(color_name)

func _mixed_color_for_pair(first_color: String, second_color: String) -> String:
	if first_color == second_color:
		return ""
	if not _is_primary_color(first_color) or not _is_primary_color(second_color):
		return ""
	if (first_color == "red" and second_color == "yellow") or (first_color == "yellow" and second_color == "red"):
		return "orange"
	if (first_color == "yellow" and second_color == "blue") or (first_color == "blue" and second_color == "yellow"):
		return "green"
	if (first_color == "red" and second_color == "blue") or (first_color == "blue" and second_color == "red"):
		return "purple"
	return ""

func _button_center(color_name: String) -> Vector2:
	var index = COLOR_ORDER.find(color_name)
	if index < 0:
		return launcher_panel.get_center()
	var x: float = float(FC_SOCKET_XS[index]) * fc_scale
	var y: float = fc_bottom_rect.position.y + (FC_SOCKET_Y - FC_BOTTOM_SRC_Y) * fc_scale
	return Vector2(x, y)

func _button_color_at(position: Vector2) -> String:
	for color_name in COLOR_ORDER:
		if position.distance_to(_button_center(color_name)) <= button_radius:
			return color_name
	return ""

func _keyboard_color(event: InputEventKey) -> String:
	if event.keycode == KEY_R:
		return "red"
	if event.keycode == KEY_Y:
		return "yellow"
	if event.keycode == KEY_B:
		return "blue"
	return ""

package objects;

import flixel.group.FlxSpriteGroup;
import flixel.FlxG;

class HitErrorMeter extends FlxSpriteGroup {
    private var errors:Array<FlxSprite> = [];
    private var barGraphic:flixel.graphics.FlxGraphic;
    public function new() {
        super(FlxG.width / 2 - 100, FlxG.height / 2 - 200);
        barGraphic = barGraphic == null ? Paths.image("bar_image") : barGraphic; // cache error graphic lmao
        add(new FlxSprite(-(ClientPrefs.data.safeFrames * 8.3 - 83), 0).makeGraphic(Std.int(ClientPrefs.data.safeFrames * 16.6 + 34), 50, 0x80000000));
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        errors = errors.filter(error -> {
            error.alpha -= elapsed / 2;
            if (error.alpha <= 0)
                remove(error).destroy();

            return error.alpha > 0;
        });
    }

    public function registerError(noteDev:Float, ratingName:String) {
        var errorSprite:FlxSprite = new FlxSprite(97.5 + noteDev, 17.5).loadGraphic(barGraphic);

        errorSprite.color = switch(ratingName) {
            case "good": 0xff00ff00;
            case "bad": 0xffff7c40;
            case "shit": 0xffff0000;
            default: 0xff00ffff;
        };

        errors.push(errorSprite);

        add(errorSprite);
    }
}
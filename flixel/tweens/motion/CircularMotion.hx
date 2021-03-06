﻿package flixel.tweens.motion;

import flixel.tweens.FlxEase.EaseFunction;
import flixel.tweens.FlxTween.CompleteCallback;

/**
 * Determines a circular motion.
 */
class CircularMotion extends Motion
{
	/**
	 * Constructor.
	 * @param	complete	Optional completion callback.
	 * @param	type		Tween type.
	 */
	public function new(?complete:CompleteCallback, type:Int = 0)
	{
		_centerX = _centerY = 0;
		_radius = angle = 0;
		_angleStart = _angleFinish = 0;
		super(0, complete, type, null);
	}

	/**
	 * Starts moving along a circle.
	 * @param	CenterX			X position of the circle's center.
	 * @param	CenterY			Y position of the circle's center.
	 * @param	Radius			Radius of the circle.
	 * @param	Angle			Starting position on the circle.
	 * @param	Clockwise		If the motion is clockwise.
	 * @param	DurationOrSpeed	Duration of the movement.
	 * @param	UseDuration		Duration of the movement.
	 * @param	Eease			Optional easer function.
	 */
	public function setMotion(CenterX:Float, CenterY:Float, Radius:Float, Angle:Float, Clockwise:Bool, DurationOrSpeed:Float, UseDuration:Bool = true, ?Ease:EaseFunction):CircularMotion
	{
		_centerX = CenterX;
		_centerY = CenterY;
		_radius = Radius;
		this.angle = _angleStart = Angle * Math.PI / ( -180);
		_angleFinish = _CIRC * (Clockwise ? 1 : -1);
		
		if (UseDuration)
		{
			_target = DurationOrSpeed;
		}
		else
		{
			_target = (_radius * _CIRC) / DurationOrSpeed;
		}
		
		_ease = Ease;
		start();
		return this;
	}

	/** @private Updates the Tween. */
	override public function update():Void
	{
		super.update();
		angle = _angleStart + _angleFinish * _t;
		x = _centerX + Math.cos(angle) * _radius;
		y = _centerY + Math.sin(angle) * _radius;
	}

	/**
	 * The current position on the circle.
	 */
	public var angle(default, null):Float;

	/**
	 * The circumference of the current circle motion.
	 */
	public var circumference(get_circumference, never):Float;
	private function get_circumference():Float { return _radius * _CIRC; }

	// Circle information.
	private var _centerX:Float;
	private var _centerY:Float;
	private var _radius:Float;
	private var _angleStart:Float;
	private var _angleFinish:Float;
	private static var _CIRC:Float = Math.PI * 2;
}
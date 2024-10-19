using RaylibBeef;

using System;

namespace ImGui;

public extension ImGui
{
	public static bool SliderFloat3(char* label, ref Vector3 vector, float v_min, float v_max, char* format = "%.3f", SliderFlags flags = (SliderFlags) 0)
	{
		float[3] v;
		v[0] = vector.x;
		v[1] = vector.y;
		v[2] = vector.z;

		bool result = ImGui.SliderFloat3(label, ref v, v_min, v_max, format, flags);

		vector.x = v[0];
		vector.y = v[1];
		vector.z = v[2];

		return result;
	}
}
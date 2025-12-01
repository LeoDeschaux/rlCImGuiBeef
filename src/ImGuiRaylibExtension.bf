using RaylibBeef;

using System;

namespace ImGui;

public extension ImGui
{
	public static bool SliderFloat2(char* label, ref Vector2 vector, float v_min, float v_max, char* format = "%.3f", SliderFlags flags = (SliderFlags) 0)
	{
		float[2] v;
		v[0] = vector.x;
		v[1] = vector.y;

		bool result = ImGui.SliderFloat2(label, ref v, v_min, v_max, format, flags);

		vector.x = v[0];
		vector.y = v[1];

		return result;
	}

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

	public static bool InputFloat2(char* label, ref Vector2 vector, char* format = "%.3f", InputTextFlags flags = (InputTextFlags) 0)
	{
		float[2] v;
		v[0] = vector.x;
		v[1] = vector.y;

		bool result = ImGui.InputFloat2(label, ref v, format, flags);

		vector.x = v[0];
		vector.y = v[1];

		return result;
	}



	public static bool ColorEdit4(char* label, ref RaylibBeef.Color color, ColorEditFlags flags = (ColorEditFlags) 0)
	{
		float[4] col = .(
			((float)color.r)/255,
			((float)color.g)/255,
			((float)color.b)/255,
			((float)color.a)/255
		);

		bool result = ImGui.ColorEdit4(label, ref col, flags);

		color = RaylibBeef.Color(
			(uint8)(col[0]*255),
			(uint8)(col[1]*255),
			(uint8)(col[2]*255),
			(uint8)(col[3]*255)
		);

		return result;
	}

	public static bool ColorPicker4(char* label, ref RaylibBeef.Color color, ColorEditFlags flags = (ColorEditFlags) 0, float* ref_col = null)
	{
		float[4] col = .(
			((float)color.r)/255,
			((float)color.g)/255,
			((float)color.b)/255,
			((float)color.a)/255
		);

		bool result = ImGui.ColorPicker4(label, ref col, flags);

		color = RaylibBeef.Color(
			(uint8)(col[0]*255),
			(uint8)(col[1]*255),
			(uint8)(col[2]*255),
			(uint8)(col[3]*255)
		);

		return result;
	}

	public static void InputText(String label, String outStrs, int maxBufferSize = 255)
	{
		char8* buffer = new char8[maxBufferSize]*;
		for(int i = 0; i < maxBufferSize-1 && i < outStrs.Length; i++)
			buffer[i] = outStrs[i];

		ImGui.InputText(label, buffer, (uint64)maxBufferSize);

		outStrs.Clear();
		outStrs.Append(buffer);

		delete buffer;
	}

	public static void InputTextMultiline(String label, String outStrs, int maxBufferSize = 255)
	{
		char8* buffer = new char8[maxBufferSize]*;
		for(int i = 0; i < maxBufferSize-1 && i < outStrs.Length; i++)
			buffer[i] = outStrs[i];

		ImGui.InputTextMultiline(label, buffer, (uint64)maxBufferSize);

		outStrs.Clear();
		outStrs.Append(buffer);

		delete buffer;
	}

	public static bool IsHoveringImGui()
	{
		var hoverRes = false; 
		hoverRes |= ImGui.IsWindowHovered(ImGui.HoveredFlags.AnyWindow);
		hoverRes |= ImGui.IsItemHovered((ImGui.HoveredFlags)0);
		hoverRes |= ImGui.IsAnyItemHovered();
		hoverRes |= ImGui.IsAnyItemActive();
		hoverRes |= ImGui.IsAnyItemFocused();

		/*
		hoverRes |= GetMousePosition().x > GetViewportSize().x;
		hoverRes |= GetMousePosition().y > GetViewportSize().y;
		*/

		return hoverRes;
	}
}
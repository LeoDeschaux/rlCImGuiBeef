using RaylibBeef;

using RaylibBeef;
using System.Collections;
using static RaylibBeef.Raylib;
using static RaylibBeef.Rlgl;
using static RaylibBeef.Color;

using System;

namespace ImGui;

public extension ImGui
{
	public static IO* GetIO_Nil() => GetIO();

	public static void PushFontScale(float scale)
	{
		var io = ImGui.GetIO_Nil();
		if(io.FontDefault != null)
		{
			ImGui.PushFont(null, ImGui.GetFontSize()*scale);
			//ImGui.PushFont(io.FontDefault, io.FontDefault.LegacySize*scale);
		}
	}

	public static void PopFontSize()
	{
		var io = ImGui.GetIO_Nil();
		if(io.FontDefault != null)
			ImGui.PopFont();
	}

	public static TextureRef RaylibTextureToImGuiTextureRef(Texture* texture)
	{
		var tex = ImGui.TextureRef();
		tex._TexID = (ImGui.TextureID)(System.Interop.c_uintptr)(void*)texture;
		return tex;
	}

	public static bool SliderFloatWithSteps(char* label, float* v, float v_min, float v_max, float v_step, char* display_format = "%.3f")
	{
		char[64] text_buf = .();
		ImFormatString(&text_buf, 64, display_format, *v);

		// Map from [v_min,v_max] to [0,N]
		int countValues = (int)((v_max-v_min)/v_step);
		int v_i = int((*v - v_min)/v_step);
		bool value_changed = SliderInt(label, (int32*)&v_i, 0, (int32)countValues, scope $"{*v}");

		// Remap from [0,N] to [v_min,v_max]
		*v = v_min + float(v_i) * v_step;
		return value_changed;
	}


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

	public static bool InputText(String label, String outStrs, int maxBufferSize = 255, ImGui.InputTextFlags flags = 0)
	{
		char8* buffer = new char8[maxBufferSize]*;
		for(int i = 0; i < maxBufferSize-1 && i < outStrs.Length; i++)
			buffer[i] = outStrs[i];

		bool res = ImGui.InputText(label, buffer, (uint64)maxBufferSize, flags);

		outStrs.Clear();
		outStrs.Append(buffer);

		delete buffer;

		return res;
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

	struct ColoredGroupContext
	{
	    public ImGui.DrawListSplitter Splitter;
	    public ImGui.DrawList* DrawList;
	    public Vector2 Min;
	    public Vector2 Max;
		public Color Color;
	}

	static List<ColoredGroupContext> sGroupStack = new .() ~ delete _;

	public static void BeginColoredGroup(Color color)
	{
		var context = ColoredGroupContext();

		context.Color = color;
		context.DrawList = ImGui.GetWindowDrawList();
		context.Splitter.Split(context.DrawList, 2);

		context.Splitter.SetCurrentChannel(context.DrawList, 1);

		context.Min = ImGui.GetCursorScreenPos();

		ImGui.PushStyleColor(.Header, .(0, 0, 0, 0));
		ImGui.PushStyleColor(.Border, .(255, 255, 255, 255));
		ImGui.PushStyleColor(.Text, .(255, 255, 255, 255));
		ImGui.PushStyleColor(.HeaderHovered, .(0,0,0,0));
		ImGui.PushStyleColor(.HeaderActive, .(0,0,0,0));

		context.Max.x = ImGui.GetWindowPos().x + ImGui.GetContentRegionAvail().x;

		sGroupStack.AddFront(context);

		ImGui.BeginGroup();
	}

	public static void EndColoredGroup()
	{
		var context = sGroupStack.PopFront();

		ImGui.PopStyleColor(5);

		ImGui.Spacing();

		var itemSpacing = ImGui.GetStyle().ItemSpacing;

		context.Max.y = ImGui.GetItemRectMax().y + itemSpacing.x;
		context.Max.x = ImGui.GetWindowPos().x + ImGui.GetItemRectMax().x;
		//context.Max.x = ImGui.GetWindowPos().x + ImGui.GetContentRegionAvail().x;

		context.Splitter.SetCurrentChannel(context.DrawList, 0);

		context.DrawList.AddRectFilled(context.Min, context.Max, ImGui.GetColorU32(context.Color.Value));
		context.Splitter.Merge(context.DrawList);

		ImGui.Spacing();

		ImGui.EndGroup();
	}

	public extension Color
	{
		public static operator uint32(ImGui.ImGui.Color val)
		{
			return RayToImGuiColorU32(val.Value);
		}
	}
}

namespace RaylibBeef;

public extension Raylib
{
	public static ImGui.ImGui.Color RayToImGuiColor(RaylibBeef.Color rayColor) {
		return .(rayColor.r/255f,rayColor.g/255f,rayColor.b/255f,rayColor.a/255f);
	}

	public static uint32 RayToImGuiColorU32(RaylibBeef.Color rayColor) {
		return ImGui.ImGui.GetColorU32(.(rayColor.r/255f,rayColor.g/255f,rayColor.b/255f,rayColor.a/255f));
	}

	public static Color ImGuiToRayColor(ImGui.ImGui.Vec4 col) {
		return .((uint8)col.x,(uint8)col.y,(uint8)col.z,(uint8)col.w);
	}
}

extension Color
{
	public static operator Color(ImGui.ImGui.Color val)
	{
		return ImGuiToRayColor(val.Value);
	}

	public static operator Color(ImGui.ImGui.Vec4 val)
	{
		return ImGuiToRayColor(val);
	}

	public static operator ImGui.ImGui.Vec4(Color val)
	{
		return RayToImGuiColor(val).Value;
	}

	public static operator ImGui.ImGui.Color(Color val)
	{
		return RayToImGuiColor(val);
	}

	/*
	public static operator uint32(RaylibBeef.Color val)
	{
		return RayToImGuiColorU32(val);
	}
	*/
}

extension Vector2
{
	public static operator Vector2(ImGui.ImGui.Vec2 val)
	{
		return Vector2(val.x, val.y);
	}

	public static operator ImGui.ImGui.Vec2(Vector2 val)
	{
		return ImGui.ImGui.Vec2(val.x, val.y);
	}
}
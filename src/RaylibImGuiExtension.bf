using RaylibBeef;
using System.Collections;
using static RaylibBeef.Raylib;
using static RaylibBeef.Rlgl;
using static RaylibBeef.Color;

namespace RaylibBeef;

public extension Raylib
{
	public static ImGui.ImGui.Vec4 RayToImGuiColor(RaylibBeef.Color rayColor) {
		return .(rayColor.r/255f,rayColor.g/255f,rayColor.b/255f,rayColor.a/255f);
	}

	public static Color ImGuiToRayColor(ImGui.ImGui.Vec4 col) {
		return .((uint8)col.x,(uint8)col.y,(uint8)col.z,(uint8)col.w);
	}
}

extension Color
{
	public static operator Color(ImGui.ImGui.Vec4 val)
	{
		return ImGuiToRayColor(val);
	}

	public static operator ImGui.ImGui.Vec4(Color val)
	{
		return RayToImGuiColor(val);
	}
}
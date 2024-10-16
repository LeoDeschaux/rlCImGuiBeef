using System;

//using ImGui;
using RaylibBeef;

namespace rlImGuiBeef;

public static class rlImGuiBeef
{
	/*
	[CLink, CallingConvention(.Stdcall)]
	[LinkName("ImGui_ImplSDL2_InitForD3D")]
	*/

	[LinkName("rlImGuiSetup")]
	public static extern void rlImGuiSetup(bool param);

	[LinkName("rlImGuiBegin")]
	public static extern void rlImGuiBegin();

	[LinkName("rlImGuiEnd")]
	public static extern void rlImGuiEnd();

	[LinkName("rlImGuiShutdown")]
	public static extern void rlImGuiShutdown();
}
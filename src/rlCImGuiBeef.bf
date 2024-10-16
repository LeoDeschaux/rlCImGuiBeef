using System;

using ImGui;
using RaylibBeef;

namespace rlCImGuiBeef;

public static class rlCImGuiBeef
{
	[CLink]
	private static extern Image GenImageColor(int width, int height, Color color);

	[CLink]
	private static extern void UnloadTexture(Texture2D texture);

	[CLink]
	private static extern Texture2D LoadTextureFromImage(Image image);

	[CLink]
	private static extern void UnloadImage(Image image);

	[CLink]
	private static extern bool ImGui_ImplRaylib_Init();

	[CLink]
	private static extern void rligSetupFontAwesome();

	[CLink]
	private static extern void ImGui_ImplRaylib_BuildFontAtlas();

	[CLink]
	private static extern bool ImGui_ImplRaylib_ProcessEvents();

	[CLink]
	private static extern void ImGui_ImplRaylib_NewFrame();

	[CLink]
	private static extern void igNewFrame();

	[CLink]
	private static extern void ImGui_ImplRaylib_RenderDrawData(ImGui.DrawData* draw_data);

	[CLink]
	private static extern void ImGui_ImplRaylib_Shutdown();

	[CLink]
	public static extern void rligShutdown();

	[CLink]
	public static extern void testDemo();






	public static void rlCImGuiSetup()
	{
		// Setup Dear ImGui context
		ImGui.CreateContext(null);
		ImGui.IO *ioptr = ImGui.GetIO();
		ioptr.ConfigFlags |= ImGui.ConfigFlags.NavEnableKeyboard; // Enable Keyboard Controls
		ioptr.ConfigFlags |= ImGui.ConfigFlags.NavEnableGamepad;  // Enable Gamepad Controls

		// Setup Dear ImGui style
		ImGui.StyleColorsDark(null);

		// Setup Platform/Renderer backends
		ImGui_ImplRaylib_Init();

		//ImFontAtlas_AddFontDefault(ioptr.Fonts, null);
		ioptr.Fonts.AddFontDefault();
		rligSetupFontAwesome();

		// required to be called to cache the font texture with raylib
		ImGui_ImplRaylib_BuildFontAtlas();
		//ioptr.Fonts.Build();
	}

	public static void rlCImGuiBegin()
	{
		// Poll and handle events (inputs, window resize, etc.)
		// You can read the io.WantCaptureMouse, io.WantCaptureKeyboard flags to tell if dear imgui wants to use your inputs.
		// - When io.WantCaptureMouse is true, do not dispatch mouse input data to your main application, or clear/overwrite your copy of the mouse data.
		// - When io.WantCaptureKeyboard is true, do not dispatch keyboard input data to your main application, or clear/overwrite your copy of the keyboard data.
		// Generally you may always pass all inputs to dear imgui, and hide them from your application based on those two flags.
		ImGui_ImplRaylib_ProcessEvents();

		// Start the Dear ImGui frame
		ImGui_ImplRaylib_NewFrame();
		ImGui.NewFrame();
	}

	public static void rlCImGuiEnd()
	{
		// Rendering
		ImGui.Render();
		ImGui_ImplRaylib_RenderDrawData(ImGui.GetDrawData());
	}

	public static void rlCImGuiShutdown()
	{
		// Cleanup
		ImGui_ImplRaylib_Shutdown();
		ImGui.DestroyContext(null);
	}
}
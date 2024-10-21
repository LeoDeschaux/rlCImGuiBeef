using System;

using RaylibBeef;
using static RaylibBeef.Raylib;

using ImGui;
using rlCImGuiBeef;

namespace example;

class Program
{
	public static void Main()
	{
		InitWindow(800, 600, scope $"Raylib Beef {RAYLIB_VERSION_MAJOR}.{RAYLIB_VERSION_MINOR}.{RAYLIB_VERSION_PATCH}");
		InitAudioDevice();

		SetTargetFPS(60);

		//SETUP
		rlCImGuiBeef.rlCImGuiSetup();
		
		while (!WindowShouldClose())
		{
			BeginDrawing();
			ClearBackground(RAYWHITE);
			DrawCircle(GetMouseX(), GetMouseY(), 8, RED);
			DrawFPS(20, 20);

			rlCImGuiBeef.rlCImGuiBegin();
			bool open = true;
			ImGui.ShowDemoWindow(&open);
			rlCImGuiBeef.rlCImGuiEnd();

			EndDrawing();
		}

		rlCImGuiBeef.rlCImGuiShutdown();

		CloseAudioDevice();
		CloseWindow();
	}
}
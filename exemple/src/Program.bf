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

		//SETUP
		rlCImGuiBeef.rlCImGuiSetup();
		
		while (!WindowShouldClose())
		{
			/*
			rlCImGuiBeef.rlCImGuiBegin();

			bool open = false;
			ImGui.ShowDemoWindow(&open);
			//rlCImGuiBeef.testDemo();

			ImGui.Render();
			BeginDrawing();
			ClearBackground(RAYWHITE);
			DrawCircle(GetMouseX(), GetMouseY(), 8, RED);
			DrawFPS(20, 20);
			
			rlCImGuiBeef.rlCImGuiEnd();

			EndDrawing();
			*/

			BeginDrawing();
			ClearBackground(RAYWHITE);
			DrawCircle(GetMouseX(), GetMouseY(), 8, RED);
			DrawFPS(20, 20);
			EndMode3D();

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
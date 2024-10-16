using System;

using RaylibBeef;
using static RaylibBeef.Raylib;

using ImGuiBeef;
using static ImGuiBeef.ImGui;

using rlImGuiBeef;

namespace exemple;

class Program
{
	public static void Main()
	{
		InitWindow(800, 600, scope $"Raylib Beef {RAYLIB_VERSION_MAJOR}.{RAYLIB_VERSION_MINOR}.{RAYLIB_VERSION_PATCH}");
		InitAudioDevice();

		rlImGuiBeef.rlImGuiSetup(true);

		Camera3D camera = .(.(0,0,0),.(0,0,0),.(0,0,0),90,0);
		camera.position = .(0.0f, 5.0f, 10.0f);
		camera.target = .(0f, 0f, 0f);
		camera.up = .(0.0f, 1.0f, 0.0f);
		camera.fovy = 45.0f;

		Vector3 cube_position = .(0,0,0);

		while (!WindowShouldClose())
		{
			BeginDrawing();

			ClearBackground(RAYWHITE);

			DrawCircle(GetMouseX(), GetMouseY(), 8, RED);
			DrawFPS(20, 20);

			UpdateCamera(&camera, 2);

			BeginMode3D(camera);
			{
			    DrawCube(cube_position, 1, 1, 1, RED);
			    DrawCubeWires(cube_position, 1, 1, 1, BLUE);
			    DrawGrid(10, 1);
			}
			EndMode3D();

			rlImGuiBeef.rlImGuiBegin();

			bool open = true;
			ImGui.ShowDemoWindow(&open);

			rlImGuiBeef.rlImGuiEnd();

			EndDrawing();
		}

		rlImGuiBeef.rlImGuiShutdown();

		CloseAudioDevice();
		CloseWindow();
	}
}
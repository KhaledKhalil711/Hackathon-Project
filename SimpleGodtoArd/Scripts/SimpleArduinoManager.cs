using Godot;
using System;
using System.IO.Ports; // Bibliothèque pour la communication série

public partial class SimpleArduinoManager : Node
{
	private SerialPort serialPort;
	private bool hasHeardFromArduino = false;
	private ulong timer;
	private RichTextLabel _richTextLabel;

	public override void _Ready()
	{
		_richTextLabel = GetNode<RichTextLabel>("RichTextLabel");

		// Ajout de texte simple
		_richTextLabel.Text = "Ceci est du texte simple.";
		try
		{
			serialPort = new SerialPort("COM6", 9600) // ⚠️ Vérifier le bon port COM ici
			{
				ReadTimeout = 500,  // Temps d'attente avant qu'une lecture échoue
				Handshake = Handshake.None, // Désactiver le contrôle de flux
				DtrEnable = true,  // Active Data Terminal Ready pour éviter le reset automatique de l'Arduino
				RtsEnable = true   // Active Request to Send
			};
			serialPort.Open();
			GD.Print("Port série ouvert avec succès !");
		}
		catch (Exception e)
		{
			GD.PrintErr($"Erreur d'ouverture du port : {e.Message}");
			serialPort = null;
		}
	}

	public override void _Process(double delta)
	{
		if (serialPort == null || !serialPort.IsOpen) return;

		try
		{
			// Vérifier s'il y a des données disponibles avant de lire
			if (serialPort.BytesToRead > 0)
			{
				string serialMessage = serialPort.ReadLine().Trim(); // Lire et supprimer les espaces
				GD.Print($"				Reçu : {serialMessage}");
				_richTextLabel.Clear(); // Nettoie l'ancien texte
				_richTextLabel.AppendText("[b]Reçu : " + serialMessage);
			
			string[] parts = serialMessage.Split(':');
			if (parts.Length == 5)
			{
				string lowJump = parts[0] == "0" ? "Low Jump : ACTIVATED" : " Low Jump : NOT ACTIVATED";
				string mediumJump = parts[1] == "0" ? "Medium Jump : ACTIVATED" : "Medium Jump : NOT ACTIVATED";
				string highJump = parts[2] == "0" ? "High Jump : ACTIVATED" : "High Jump : NOT ACTIVATED";
				
				int joystickX = int.Parse(parts[3]);
			int joystickY = int.Parse(parts[4]);
			
			string Xdir = "";
			string Ydir = "";
			
			
			if (joystickX > 800)
			Xdir = "RIGHT";
			if (joystickX < 100)
			Xdir = "LEFT";
			if (joystickY > 700)
			Ydir = "UP";
			if (joystickY < 100)
			Ydir = "DOWN";
			
			string joyStickXValue = $"X :{Xdir}";
			string joyStickYValue = $"Y :{Ydir}";
				
				
				_richTextLabel.Clear();
					_richTextLabel.AppendText($"[b]{lowJump}\n{mediumJump}\n{highJump}[/b]\n{joyStickXValue}\n{joyStickYValue}");
			}
			
			
			
			
			}
		}
		catch (TimeoutException)
		{
			// Ne rien afficher pour éviter de polluer la console
		}
		catch (Exception e)
		{
			GD.PrintErr($"⚠️ Erreur de lecture du port série : {e.Message}");
		}

		// Envoyer une commande à l'Arduino toutes les 1.5 secondes (soit 1, soit 0).
		if (Time.GetTicksMsec() - timer > 1500)
		{
			timer = Time.GetTicksMsec();
			try
			{
				if(hasHeardFromArduino){
					GD.Print("Envoyé : 1");
					serialPort.Write("1"); // Envoie '1' à Arduino
				}
				else{
					GD.Print("Envoyé : 0");
					serialPort.Write("0"); // Envoie '1' à Arduino
				}
				hasHeardFromArduino = !hasHeardFromArduino;
			}
			catch (Exception e)
			{
				GD.PrintErr($"⚠️ Erreur d'écriture sur le port série : {e.Message}");
			}
		}
	}

	public override void _ExitTree()
	{
		if (serialPort != null && serialPort.IsOpen)
		{
			serialPort.Close();
			GD.Print("Port série fermé.");
		}
	}
}

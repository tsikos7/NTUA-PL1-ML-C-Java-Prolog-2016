import java.util.*;
import java.io.*;

public class Dominos	{
	private int[][] Map = new int[8][9];
	private int[][] Map2 = new int[8][9];
	private int[][] Map_Copy = new int[8][9];
	private int[][] Availlable = new int[7][7];
	private int count = 0;

	public void Dominos ()	{
		int i;
		int j;
		for (i = 0 ; i < 7 ; i++)	{
			for (j = 0 ; j < 7 ; j++)	{
				Availlable[i][j] = 0;
				Map_Copy[i][j] = -1;
			}
		}
		for (j = 0 ; j < 7 ; j++)	{
			Map_Copy[j][7] = -1;
		}
		
	}

	public int findi (int i, int j, int k)	{
		for (int i2 = 0 ; i2 < 8 ; i2++)	{
			for (int j2 = 0 ; j2 < 9 ; j2++)	{
				if (Map[i2][j2] == i && Map[i2][j2+1] == j) {
					
					if (k == 0) return i2;
					else k--;
				}
				if (Map[i2][j2] == j && Map[i2][j2+1] == i && i != j) {
					if (k == 0) return i2;
					else k--;
				}
				if (Map[i2][j2] == i && Map[i2+1][j2] == j) {
					if (k == 0) return i2;
					else k--;
				}
				if (Map[i2][j2] == j && Map[i2+1][j2] == i && i != j) {
					if (k == 0) return i2;
					else k--;
				}
				if (i2 == 7 && j2 == 8) return -1;

			}
		}
		return -9;
	}

	public int findj (int i, int j, int k)	{
		for (int i2 = 0 ; i2 < 8 ; i2++)	{
			for (int j2 = 0 ; j2 < 9 ; j2++)	{
				if (Map[i2][j2] == i && Map[i2][j2+1] == j) {
					if (k == 0) return j2;
					else k--;
				}
				if (Map[i2][j2] == j && Map[i2][j2+1] == i && i != j) {
					if (k == 0) return j2;
					else k--;
				}
				if (Map[i2][j2] == i && Map[i2+1][j2] == j) {
					if (k == 0) return j2;
					else k--;
				}
				if (Map[i2][j2] == j && Map[i2+1][j2] == i && i != j) {
					if (k == 0) return j2;
					else k--;
				}
				if (i2 == 7 && j2 == 8) return -1;

			}
		}
		return -9;
	}

	public int finddir (int i, int j, int k)	{
		for (int i2 = 0 ; i2 < 8 ; i2++)	{
			for (int j2 = 0 ; j2 < 9 ; j2++)	{
				if (Map[i2][j2] == i && Map[i2][j2+1] == j) {	//horizontal
					if (k == 0) return 0;
					else k--;
				}			
				if (Map[i2][j2] == j && Map[i2][j2+1] == i && i != j) {
					if (k == 0) return 0;
					else k--;
				}
				if (Map[i2][j2] == i && Map[i2+1][j2] == j) {//vertical
					if (k == 0) return 1;
					else k--;
				}
				if (Map[i2][j2] == j && Map[i2+1][j2] == i && i != j) {
					if (k == 0) return 1;
					else k--;
				}
				if (i2 == 7 && j2 == 8) return -1;
			}
		}
		return -9;
	}

	
	public int Sugar (int i, int j, int k, int l, int r)	{
		int i2;
		int j2;
		int dir = 0;

		while (dir != -1)	{
			i2 = findi(i, j, k);
			j2 = findj(i, j, k);
			dir = finddir(i, j, k);
			if (i == 7 && j == 7) count++;
			//HIDE domino
			if (dir != -1)Map[i2][j2] = -10;
			if (dir == 0) Map[i2][j2+1] = -10;
			else if (dir == 1) Map[i2+1][j2] = -10;

			/*System.out.println();
			System.out.println("Domino: [" + i + ", " + j + "]");			//Debug Log
			if (dir != -1) System.out.println("Number: " + (k+1));
			if (dir != -1) System.out.println("Coordinates found: (" + i2 + ", " + j2 + ")");
			if (dir == 0) System.out.println("Direction: HORIZONTAL");
			else if (dir == 1) System.out.println("Direction: VERTICAL");
			else if (dir == -1)System.out.println("WARNING: No More Dominoes!!");
			System.out.println();
			printmap();
			System.out.println();*/

			k++;
			if (dir != -1 && j!= l) Sugar(i, j+1, 0, l, r);
			else if (dir != -1 && j == l) Sugar(i+1, r+1, 0, l, r+1);

			if (dir != -1) Map[i2][j2] = Map2[i2][j2];
			if (dir == 0) Map[i2][j2+1] = Map2[i2][j2+1];
			else if (dir == 1) Map[i2+1][j2] = Map2[i2+1][j2];

		}
		return count;
	}


	public static void main (String[] args) throws FileNotFoundException	{
		String infile = args[0];
		File file = new File(infile);
		Scanner scanner = new Scanner(file);
		Dominos stage = new Dominos();
		stage.Dominos();
		String Direction = new String("Begin");
		for (int i = 0 ; i < 7 ; i++)	{
			for (int j = 0 ; j < 8 ; j++)	{
				if (scanner.hasNextInt())    {
    				stage.Map[i][j] = scanner.nextInt();
    				stage.Map2[i][j] = stage.Map[i][j];
    				

    			}
			}
		}
		for (int i = 0 ; i < 9 ; i++)	{
			stage.Map[7][i] = 8;
			stage.Map2[7][i] = 8;
			if (i != 8) {
				stage.Map[i][8] = 8;
				stage.Map2[i][8] = 8;
			}
			stage.Map_Copy[7][i] = 9;
			if (i != 8) stage.Map_Copy[i][8] = 9;
		} 

		stage.Sugar(0, 0, 0, 6, 0);
		

		System.out.println(stage.count);


		
	}
}


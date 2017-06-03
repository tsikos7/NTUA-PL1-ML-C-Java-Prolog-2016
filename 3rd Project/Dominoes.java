import java.util.*;
import java.io.*;

public class Dominoes	{
	private int[][] Map = new int[8][9];
	private int[][] Map_Copy = new int[8][9];
	private int[][] Availlable = new int[7][7];
	private int[] Counter = new int[32];
	private int count = 0;

	public void Dominoes ()	{
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

	public void IncreaseCounter () {
		int i = 31;
		while (Counter[i] == 1)	{
			Counter[i] = 0;
			i--;
		}
		Counter[i] = 1;
		return;
	}

	public int IsAvaillable (int i2, int j2)	{
		if (i2 == 9 || j2 == 9) return -1;

			if (Availlable[i2][j2] == 1) return 0;
			Availlable[i2][j2]++;
			if (j2 != i2) Availlable[j2][i2]++;
			return 1;


	}

	public int CheckLine (int i) {
		int k = 1;
		for (int j = 0 ; j < 8 ; j++)	{
			if (Map_Copy[i][j] != Map[i][j])	{
				k = 0;
				break;
			}
		}
		return k;
	}

	public void PrintCounter ()	{
		for (int i = 0 ; i < 32 ; i++)	{
     		System.out.print(Counter[i] + " ");
		}
		System.out.println();
		return;
	}

	public void printcopy ()	{
		for (int i = 0 ; i < 8 ; i++)	{
			for (int j = 0 ; j < 9 ; j++)	{
     			System.out.print(Map_Copy[i][j] + "\t");
   				if (j == 8) System.out.println();
   			}
		}
	}

	public void printavail ()	{
		for (int i = 0 ; i < 7 ; i++)	{
			for (int j = 0 ; j < 7 ; j++)	{
     			System.out.print("(" + i + "," + j + "):" + Availlable[i][j] + "\t");
   				if (j == 6) System.out.println();
   			}
		}
	}

	public void DFSSearch (int i, int j)	{
		int A;
		int B;
		int flag = 0;
		int flag2 = 0;
		while (Map_Copy[i][j] != -1 && j!= 8) j++;
		//horizontal

		if (Map_Copy[i][j+1] != -1) {
			flag = 1;
			if (Map_Copy[i][j+1] != 9) flag2 = 1;
			else flag2 = 0;
		}

		A = Map[i][j];
		B = Map[i][j+1];
		if (flag == 0)	{
			if (IsAvaillable(A, B) == 1 && j != 7) flag = 0;
			else flag = 1;

			Map_Copy[i][j] = A;
			Map_Copy[i][j+1] = B;
		}

		printcopy();
		System.out.println(flag);
		printavail();
		System.out.println("Mode: HORIZONTAL");
		System.out.println("A = " + A);
		System.out.println("B = " + B);
		System.out.println("Coordinates: (" + i + ", " + j + ")");
		System.out.println();

		//DFS
		if (flag == 0 && CheckLine(i) == 1) DFSSearch(i+1, 0);
		if (flag == 0 && j != 6) DFSSearch(i, j+2);
		if (flag == 0 && j == 6) DFSSearch(i+1, j-6);

		if (j != 7 && flag == 0)Availlable[A][B] = 0;
		Map_Copy[i][j] = -1;
		if (j != 7 && flag2 == 0) Map_Copy[i][j+1] = -1;


		//Vertical
		A = Map[i][j];
		B = Map[i+1][j];

		if (IsAvaillable(A, B) == 1) flag = 0;
		else flag = 1;
// FIX AVAILLABILITY MISTAKE AAAASSSAAAAPPP
		Map_Copy[i][j] = A;
		Map_Copy[i+1][j] = B;

		printcopy();
		System.out.println(flag);
		printavail();
		System.out.println("Mode: VERTICAL");
		System.out.println("A = " + A);
		System.out.println("B = " + B);
		System.out.println("Coordinates: (" + i + ", " + j + ")");
		System.out.println();

		//DFS
		if (flag == 0 && CheckLine(i) == 1) DFSSearch(i+1, 0);
		if (flag == 0 && j != 7) DFSSearch(i, j+1);
		if (flag == 0 && j == 7) DFSSearch(i+1, j-7);

		if (j != 7 && flag == 0)Availlable[A][B] = 0;
		Map_Copy[i][j] = -1;
		Map_Copy[i+1][j] = -1;

		return;
	}


	public static void main (String[] args) throws FileNotFoundException	{
		String infile = args[0];
		File file = new File(infile);
		Scanner scanner = new Scanner(file);
		Dominoes stage = new Dominoes();
		stage.Dominoes();
		String Direction = new String("Begin");
		System.out.println("//////////////////////////////////////////////////////////////////////////////////");
		System.out.println("//////////////////////////////////////////////////////////////////////////////////");
		System.out.println("//////////////////////////////////////////////////////////////////////////////////");
		System.out.println("//////////////////////////////////////////////////////////////////////////////////");
		System.out.println("//////////////////////////////////////////////////////////////////////////////////");
		System.out.println("//////////////////////////////////////////////////////////////////////////////////");
		System.out.println("//////////////////////////////////////////////////////////////////////////////////");
		for (int i = 0 ; i < 7 ; i++)	{
			for (int j = 0 ; j < 8 ; j++)	{
				if (scanner.hasNextInt())    {
    				stage.Map[i][j] = scanner.nextInt();
    				System.out.print(stage.Map[i][j] + " ");
    				if (j == 7) System.out.println();

    			}
			}
		}
		for (int i = 0 ; i < 9 ; i++)	{
			stage.Map[7][i] = 9;
			if (i !=8 )stage.Map[i][8] = 9;
			stage.Map_Copy[7][i] = 9;
			if (i !=8 )stage.Map_Copy[i][8] = 9;
		}

		stage.DFSSearch(0,0);




	}
}

#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main(int argc, char** argv)
{
    int k, w, h;

    string input_path = string(argv[1]);

    ifstream fin(input_path);

    fin >> h >> w >> k;

    string *horizontal_eq = new string[h];
    string *vertical_eq = new string[h - 1];

    for (int i = 0; i < h - 1; ++i)
    {
        fin >> horizontal_eq[i];
        fin >> vertical_eq[i];
    }
    fin >> horizontal_eq[h - 1];

    int **colors = new int*[h];
    for (int i = 0; i < h; ++i)
        colors[i] = new int[w];

    for (int i = 0; i < h; ++i)
        for (int j = 0; j < w; ++j)
        {
            cin >> colors[i][j];
        
            if (colors[i][j] <= 0 || colors[i][j] > k)
            {
                cout << 0 << endl;
                return 0;
            }
        }

    int result = 0;

    for (int i = 0; i < h; ++i)
    {
        for (int j = 0; j < w - 1; ++j)
        {
            if (horizontal_eq[i][j] == 'E')
            {
                if (colors[i][j] == colors[i][j + 1])
                    ++result;
            }
            else if (horizontal_eq[i][j] == 'N')
            {
                if (colors[i][j] != colors[i][j + 1])
                    ++result;
            }
            else
            {
                cout << "Invalid Input!" << endl;
                return 1;
            }
        }
    }

    for (int i = 0; i < h - 1; ++i)
    {
        for (int j = 0; j < w; ++j)
        {
            if (vertical_eq[i][j] == 'E')
            {
                if (colors[i][j] == colors[i + 1][j])
                    ++result;
            }
            else if (vertical_eq[i][j] == 'N')
            {
                if (colors[i][j] != colors[i + 1][j])
                    ++result;
            }
            else
            {
                cout << "Invalid Input!" << endl;
                return 1;
            }
        }
    }

    cout << result << endl;

    return 0;
}
#include <iostream>
#include <fstream>
#include <string>
#include <map>

using namespace std;

int main(int argc, char** argv)
{
    string input_path = argv[1];
    ifstream fin(input_path);

    map <int, int> weights;
    int n, c;
    
    fin >> n >> c;

    int a;
    for (int i = 0; i < n; ++i)
    {
        fin >> a;
        if (weights.count(a)) // weight a already exists in weights
        {
            ++weights[a];
        }
        else
        {
            weights.insert(pair<int, int>(a, 1));
        }
    }

    int action;
    int result = 0;
    while (cin >> action)
    {
        if (action > 0)
        {
            if (weights.count(action)) // weight a exists in weights
            {
                --weights[action];
                result += action;
            }
        }
        else if (action == 0)
        {
            result *= 2;
        }
        else
        {
            result = 0;
            break;
        }
        
    }

    if (result > c)
        result = 0;

    cout << result << endl;

    return 0;
}
#include <iostream>
#include <fstream>
#include <string>
#include <map>

using namespace std;

int main(int argc, char** argv)
{
    string input_path = argv[1];
    ifstream fin(input_path);

    map < pair <int, int>, int > friendship;
    int n, m;
    
    fin >> n >> m;

    int u, v, c;

    for (int i = 0; i < m; ++i)
    {
        fin >> u >> v >> c;

        if (u > n || u <= 0 || v > n || v <= 0 || u == v)
        {
            cout << "Invalid Input!" << endl;
            return 1;
        }
        else
        {
            friendship[make_pair(u, v)] = c;
            friendship[make_pair(v, u)] = c;
        }
    }

    int k;
    long long result = 0;

    bool *in_team = new bool[n + 1];

    for (int i = 0; i <= n; ++i)
        in_team[i] = false;

    cin >> k;

    int s1, s2, s3;
    for (int i = 0; i < k; ++i)
    {
        cin >> s1 >> s2 >> s3;

        if (s1 > n || s1 <= 0 || s2 > n || s2 <= 0 || s3 > n || s3 <= 0 
            || in_team[s1] || in_team[s2] || in_team[s3])
        {
            cout << "Invalid Output!" << endl;
            return 0;
        }

        result += (friendship.count(make_pair(s1, s2))) ? friendship[make_pair(s1, s2)] : 0;
        result += (friendship.count(make_pair(s2, s3))) ? friendship[make_pair(s2, s3)] : 0;
        result += (friendship.count(make_pair(s1, s3))) ? friendship[make_pair(s1, s3)] : 0;
        
        in_team[s1] = true;
        in_team[s2] = true;
        in_team[s3] = true;
    }

    cout << result << endl;

    return 0;
}
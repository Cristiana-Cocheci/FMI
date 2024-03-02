#include <bits/stdc++.h>
using namespace std;

using f64 = double;
const f64 INF = numeric_limits<f64>::max() / 3;
const int MAX_N = 17;

f64 dp[1 << MAX_N][MAX_N][2];
f64 dist[MAX_N][MAX_N][2][2];

struct Point {
  f64 x, y;
};

struct Segment {
  Point a, b;
};

pair<int, vector<Segment>> read() {
  int N;
  cin >> N;
  vector<Segment> segment(N);
  for (auto &[a, b] : segment) {
    cin >> a.x >> a.y >> b.x >> b.y;
  }
  return {N, segment};
}

f64 solve(int N, const vector<Segment> &segments) {
  if (N == 1) {
    return 0;
  }

  function<f64(const Point&, const Point &)> get_distance = [&](const Point &P, const Point &Q) -> f64 {
    return hypotf(P.x - Q.x, P.y - Q.y);
  };

  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N - 1; j++) {
      dist[i][j][0][0] = get_distance(segments[i].a, segments[j].a);
      dist[i][j][0][1] = get_distance(segments[i].a, segments[j].b);
      dist[i][j][1][0] = get_distance(segments[i].b, segments[j].a);
      dist[i][j][1][1] = get_distance(segments[i].b, segments[j].b);
    }
  }

  for (int subset = 0; subset < (1 << (N - 1)); subset++) {
    for (int last = 0; last < N; last++) {
      dp[subset][last][0] = dp[subset][last][1] = INF;
    }
  }

  dp[0][N - 1][0] = 0;
  for (int subset = 0; subset < (1 << (N - 1)); subset++) {
    for (int last = 0; last < N; last++) {
      if ((subset & (1 << last)) > 0 || last == N - 1) {
        for (int next = 0; next < N - 1; next++) {
          if ((subset & (1 << next)) == 0) {
            dp[subset | (1 << next)][next][0] = min(dp[subset | (1 << next)][next][0],
                        dp[subset][last][1] + dist[last][next][0][0]);
            dp[subset | (1 << next)][next][0] = min(dp[subset | (1 << next)][next][0],
                        dp[subset][last][0] + dist[last][next][1][0]);
            dp[subset | (1 << next)][next][1] = min(dp[subset | (1 << next)][next][1],
                        dp[subset][last][1] + dist[last][next][0][1]);
            dp[subset | (1 << next)][next][1] = min(dp[subset | (1 << next)][next][1],
                        dp[subset][last][0] + dist[last][next][1][1]);
            cout<<dp[subset | (1 << next)][next][0]<<" "<<dp[subset][last][1] + dist[last][next][0][0]<<"\n";
            cout<<dp[subset | (1 << next)][next][0]<<" "<<dp[subset][last][0] + dist[last][next][1][0]<<"\n";
            cout<<dp[subset | (1 << next)][next][1]<<" "<<dp[subset][last][1] + dist[last][next][0][1]<<"\n";
            cout<<dp[subset | (1 << next)][next][1]<<" "<<dp[subset][last][0] + dist[last][next][1][1]<<"\n";
          }
        }
      }
    }
  }

  f64 answer = INF;
  for (int last = 0; last < N - 1; last++) {
    answer = min(answer, dp[(1 << (N - 1)) - 1][last][0] + get_distance(segments[last].b, segments[N - 1].a));
    answer = min(answer, dp[(1 << (N - 1)) - 1][last][1] + get_distance(segments[last].a, segments[N - 1].a));
  }
  cout<<"distante/n";
  for(int i=0;i<N; i++){
            for(int j=0;j<N-1; j++){
                cout<<dist[i][j][0][0]<<" "<<dist[i][j][0][1]<<" "<<dist[i][j][1][0]<<" "<<dist[i][j][1][1]<<"; ";
            }
            cout<<"\n";
        }
        cout<<"dp\n";
  for(int subset = 0; subset < (1 << (N - 1)); subset++){
            cout<<subset<<" :: ";
            for(int nod = 0; nod<N; nod++){
                cout<<nod<<" "<<dp[subset][nod][0]<<" "<<dp[subset][nod][1]<<"; ";
            }
            cout<<"\n";
        }
  return answer;
}

int main() {
  ios::sync_with_stdio(false);
  cin.tie(nullptr);
freopen("segv.in", "r", stdin);
  freopen("segv.out", "w", stdout);

  int T;
  cin >> T;
  for (int t = 0; t < T; t++) {
    auto [N, segment] = read();
    f64 answer = solve(N, segment);
    cout << fixed << setprecision(9) << answer << endl;
  }

  return 0;
}

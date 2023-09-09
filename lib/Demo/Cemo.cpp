#include<bits/stdc++.h>
using namespace std;

int main(){
	long n;
	cin>>n;
	vector<pair<int,int>> v(n);
	for (int i=0;i<n;i++){
		cin>>v[i].second>>v[i].first;
		v[i].first += v[i].second;
	}
	sort(v.begin(),v.end());
	int cnt = 1;
	auto comp = v[0];
	for (int i=1;i<n;i++){
		if(v[i].second >= comp.first + 1){
			comp = v[i];
			cnt++;
		}
	}
	cout<<cnt<<"\n";
	return 0;
}
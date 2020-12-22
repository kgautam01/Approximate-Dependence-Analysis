#include <stdio.h>
int main()
{
    int a;
    int c = 2;
    int arr[100];
    for (int i = 0; i < 100; i++)
    {
        a = arr[i+1] + c;
        arr[i-2] = c*10;
    }
    return 0;
}
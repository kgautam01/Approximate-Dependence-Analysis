#include <stdio.h>
int main()
{
    int c = 2;
    int arr[100];
    for(int i=0; i<100; i++)
    {
        arr[i] = arr[i + 1] + c;
    }

    for (int i = 0; i < 100; i++)
    {
        c = c*2;
        arr[i] = c;
        arr[i-2] = arr[i];
    }

    return 0;
}
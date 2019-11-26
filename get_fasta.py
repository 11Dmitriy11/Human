def main():
 d={}
 with open ('mafft.txt', 'r') as f, open('mafft_out.txt', 'w') as out:
  string =f.readlines()
  for i in string:
    if i.strip() and i[0] != ' ':
       out.write(i)
    if i[0] == ' ':
       i=list(i)
       i[0:9] = 'mutations'
       for k in range (16,len(i)):
           if i[k] == ' ':
              i[k] = '#'
       i = ''.join(i)
       out.write(i)
 with open('mafft_out.txt', 'r') as out:
  f=out.readlines()
  for i in range(len(f)):
        if i <= 53:
            key, *value = f[i].split()
            d[key] = value
        else:
            key, *value = f[i].split()
            d[key] += value
 for key, value in d.items():
         value =''.join(value) 
         d[key] = value
 with open ('align.txt', 'w') as f:
     for key, value in d.items():
       if key != 'mutations':
         f.write('>'+key+'\n')
         f.write(value+'\n')

if __name__=='__main__':

    main()
           
           

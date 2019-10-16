birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

latinNames = []
commonNames = []
meanBodyMasses = []
for i in range(len(birds)):
    latinNames.append(birds[i][0])
    commonNames.append(birds[i][1])
    meanBodyMasses.append(birds[i][2])
print(latinNames)
print(commonNames)
print(meanBodyMasses)

    
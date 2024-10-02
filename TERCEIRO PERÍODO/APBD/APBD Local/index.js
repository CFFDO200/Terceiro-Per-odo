const doc = document.querySelector('#enviar')

doc.addEventListener('click', (e) => {
  
    const temperature = document.getElementById('temperature').value;
    const timeTemperature = document.getElementById('time-temperature').value;
    const food = document.getElementById('food').value;
    const timeFood = document.getElementById('time-food').value;

    console.log('Temperature:', temperature);
    console.log('Time-Temperature:', timeTemperature);
    console.log('Food:', food);
    console.log('Time-Food:', timeFood);

      const tableRow = document.createElement('tr');
      const tableData1 = document.createElement('td');
      const tableData2 = document.createElement('td');
      const tableData3 = document.createElement('td');
      const tableData4 = document.createElement('td');

      tableData1.textContent = temperature;
      tableData2.textContent = timeTemperature;
      tableData3.textContent = food;
      tableData4.textContent = timeFood;

      tableRow.appendChild(tableData1);
      tableRow.appendChild(tableData2);
      tableRow.appendChild(tableData3);
      tableRow.appendChild(tableData4);

      const table = document.querySelector('table');
      table.appendChild(tableRow);

      temperature.value = '';
      timeTemperature.value = '';
      food.value = '';
      timeFood.value = '';
    });
    


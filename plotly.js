  <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">
                            Defence Services (Revenue) 
                        </h5>
            
                        <!-- Bar Chart 2 -->
                        <div id="barChart2" style="width: 100%; height: 800px;"></div>
                        <script>
                            document.addEventListener("DOMContentLoaded", () => {
                                // Sample data (replace these with your context variables)
                                const labels = {{ minorhd_desc_20|safe }};  // Labels from Django context
                                const dataValues = {{ amt_20|safe }};      // Data values from Django context
            
                                const data = [{
                                    type: 'bar',
                                    x: dataValues,                      // Data for the x-axis (horizontal)
                                    y: labels,                          // Data for the y-axis (vertical)
                                    orientation: 'h',                   // Horizontal orientation
                                    marker: {
                                        color: [
                                            'rgba(255, 99, 132, 0.2)',
                                            'rgba(255, 159, 64, 0.2)',
                                            'rgba(255, 205, 86, 0.2)',
                                            'rgba(75, 192, 192, 0.2)',
                                            'rgba(54, 162, 235, 0.2)',
                                            'rgba(153, 102, 255, 0.2)',
                                            'rgba(201, 203, 207, 0.2)'
                                        ],
                                        line: {
                                            color: [
                                                'rgb(255, 99, 132)',
                                                'rgb(255, 159, 64)',
                                                'rgb(255, 205, 86)',
                                                'rgb(75, 192, 192)',
                                                'rgb(54, 162, 235)',
                                                'rgb(153, 102, 255)',
                                                'rgb(201, 203, 207)'
                                            ],
                                            width: 1
                                        }
                                    },
                                    text: dataValues,                  // Show data values on bars
                                    textposition: 'auto',              // Position the text automatically
                                }];
            
                                const layout = {
                                    title: 'Grant-20',
                                    xaxis: {
                                        title: 'Amount',
                                        zeroline: true
                                    },
                                    yaxis: {
                                        title: 'Description',
                                        autorange: 'reversed',  // To reverse the y-axis
                                        tickangle: -45,         // Rotate y-axis labels to make them fit better
                                        automargin: true        // Automatically adjust margin to prevent clipping
                                    },
                                    showlegend: false
                                };
            
                                // Render the chart
                                Plotly.newPlot('barChart2', data, layout);
                            });
                        </script>
                        <!-- End Bar Chart 2 -->
                    </div>
                </div>
            </div>

FROM mcr.microsoft.com/windows/servercore:ltsc2025 AS download
WORKDIR /download
RUN powershell -Command \
    Invoke-WebRequest -Uri "https://github.com/microsoft/IIS.ServiceMonitor/releases/download/v2.0.1.10/ServiceMonitor.exe" -OutFile ".\ServiceMonitor.exe"; \
    Invoke-WebRequest -Uri "https://github.com/microsoft/windows-container-tools/releases/download/v2.1.3/LogMonitor.exe" -OutFile ".\LogMonitor.exe"

FROM mcr.microsoft.com/windows/nanoserver:ltsc2025
WORKDIR /install
COPY install_iis.cmd ./
COPY --from=download /download/ ./
USER ContainerAdministrator
RUN install_iis.cmd
WORKDIR /LogMonitor
COPY LogMonitorConfig.json ./
ENTRYPOINT ["C:\\install\\LogMonitor.exe", "C:\\install\\ServiceMonitor.exe", "W3SVC"]

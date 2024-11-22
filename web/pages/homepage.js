import Sidebar from "/components/Sidebar";
import React from "react";
import Image from "next/image";

export default function Homepage() {
  return (
    <div style={styles.container}>
      <Sidebar />
      <main style={styles.mainContent}>
        <h1 style={styles.title}>Don Macchiatos</h1>
        <h2 style={styles.subTitle}>Branch Highlights</h2>
        <div style={styles.imageGrid}>
          {/* Branch 1 */}
          <div style={styles.branchCard}>
            <Image
              src="/images/branchopol.png"
              alt="Opol Branch"
              layout="responsive"
              width={500}
              height={300}
              style={styles.highlightImage}
            />
            <p style={styles.branchDescription}>
              <strong>Grand Opening - Opol Branch</strong>
              <br />
              Join us in celebrating the grand opening of our Opol branch.
              Enjoy our 3-for-100 promo!
            </p>
          </div>

          {/* Branch 2 */}
          <div style={styles.branchCard}>
            <Image
              src="/images/branchdasmarinas.png"
              alt="Dasmarinas Branch"
              layout="responsive"
              width={500}
              height={300}
              style={styles.highlightImage}
            />
            <p style={styles.branchDescription}>
              <strong>Dasmarinas Branch</strong>
              <br />
              Our Dasmariñas branch conducted an outreach program to give back to the community.
            </p>
          
            </div>
            {/* Branch 3 */}
          <div style={styles.branchCard}>
            <Image
              src="/images/branchlingayen.png" // Replace with your actual image path
              alt="Lingayen Branch"
              layout="responsive"
              width={500}
              height={300}
              style={styles.highlightImage}
            />
            <p style={styles.branchDescription}>
              <strong>Lingayen Branch</strong>
              <br />
              Get ready, coffee lovers! Buhisan branch is opening soon!!
            </p>
          </div>

          {/* Branch 4 */}
          <div style={styles.branchCard}>
            <Image
              src="/images/branchopol.png" // Replace with your actual image path
              alt="Pol Branch"
              layout="responsive"
              width={500}
              height={300}
              style={styles.highlightImage}
            />
            <p style={styles.branchDescription}>
              <strong>Opol Branch</strong>
              <br />
              'Join us in celebrating the grand opening of our Opol branch. Enjoy our 3-for-100 promo!
            </p>
          </div>
          <div style={styles.branchCard}>
            <Image
              src="/images/branchtabunok.png" // Replace with your actual image path
              alt="Pol Branch"
              layout="responsive"
              width={500}
              height={300}
              style={styles.highlightImage}
            />
            <p style={styles.branchDescription}>
              <strong>Tabunok</strong>
              <br />
              Grand opening celebration with special guest Ariel Alegado. Don’t miss out!          
            </p>
          </div>
          <div style={styles.branchCard}>
            <Image
              src="/images/branchbuhisan.png" // Replace with your actual image path
              alt="Pol Branch"
              layout="responsive"
              width={500}
              height={300}
              style={styles.highlightImage}
            />
            <p style={styles.branchDescription}>
              <strong>Buhisan Branch</strong>
              <br />
              Get ready, coffee lovers! Buhisan branch is opening soon!            
              </p>
          </div>
        </div>
        
      </main>
    </div>
  );
}

const styles = {
  container: {
    fontFamily: "'Segoe UI', Tahoma, Geneva, Verdana, sans-serif",
    backgroundColor: "#f7f0e3",
    minHeight: "100vh",
    display: "flex",
    flexDirection: "row",
  },
  title: {
    fontSize: "3rem",
    fontWeight: "bold",
    textAlign: "center",
    color: "#4b3025", // Coffee-themed color
    marginBottom: "20px",
    textTransform: "uppercase",
    letterSpacing: "3px",
    textShadow: "2px 2px 4px rgba(0, 0, 0, 0.2)", // Subtle shadow effect
    padding: "10px 0",
    borderBottom: "2px solid #d49d6e", // Add a golden coffee-colored underline
    display: "inline-block",
    marginTop: "20px",
  },
  mainContent: {
    flex: 1,
    padding: "20px",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
  },
  subTitle: {
    fontSize: "2rem",
    color: "#4b3025",
    marginBottom: "20px",
    fontWeight: "bold",
  },
  imageGrid: {
    display: "grid",
    gridTemplateColumns: "repeat(2, 1fr)",
    gap: "20px",
    width: "100%",
    maxWidth: "1200px",
  },
  branchCard: {
    backgroundColor: "#fff8e7",
    borderRadius: "12px",
    overflow: "hidden",
    boxShadow: "0px 4px 8px rgba(0, 0, 0, 0.1)",
    padding: "15px",
    textAlign: "center",
  },
  branchDescription: {
    marginTop: "10px",
    fontSize: "1rem",
    color: "#4b3025",
    fontWeight: "bold",
  },
  highlightImage: {
    borderRadius: "12px",
  },
};
